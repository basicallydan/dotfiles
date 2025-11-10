#!/bin/bash

# e:          Exit on non-0 exit status
# u:          Exit when undefined variable
# o pipefail: Exit when any pipeline error occurs, no masking
set -euo pipefail

install_brew() {
    if ! command -v "brew" &> /dev/null; then
        printf "Homebrew not found, installing."
        # install homebrew
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # set path
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    printf "Installing homebrew packages..."
    brew bundle
}

create_dirs() {
    declare -a dirs=(
        "$HOME/Code"
        "$HOME/Desktop/Screenshots"
    )

    for i in "${dirs[@]}"; do
        mkdir -p "$i"
    done
}

build_xcode() {
    if ! xcode-select --print-path &> /dev/null; then
        xcode-select --install &> /dev/null

        until xcode-select --print-path &> /dev/null; do
            sleep 5
        done

        sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

        sudo xcodebuild -license
    fi
}

install_app_store_apps() {
    # mas install 497799835 # Xcode
    mas install 1545870783 # System Color Picker
    # mas install 1672085276 # Aiko
    # mas install 1055511498 # Day One
    # mas install 1500855883 # CapCut
    # mas install 897446215 # Canva
}

# This seems to cause the whole script to end, so you gotta run it twice lol
install_oh_my_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        printf "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    printf "Installing Oh My Zsh plugins..."
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    fi
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    fi
}

DOTFILES_ROOT=$(pwd -P)

install_symlinks () {
    echo "Installing symlinks"

    for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
    do
        dst="$HOME/.$(basename "${src%.*}")"
        ln -sf "$src" "$dst"
    done
}

configure_node() {
    # install n for version management
    npm install -g n 1>/dev/null
    # make cache folder (if missing) and take ownership
    sudo mkdir -p /usr/local/n
    sudo chown -R $(whoami) /usr/local/n
    sudo mkdir -p /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
    sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
    # install and use node lts
    n lts
}

echo "🗄 Creating directories"
create_dirs

printf "🛠 Installing Xcode Command Line Tools\n"
build_xcode

echo "🍺 Installing Homebrew"
install_brew

echo "🛍️ Installing Mac App Store apps"
install_app_store_apps

echo "🚀 Installing Oh My Zsh"
install_oh_my_zsh

echo "💻 Set macOS Preferences"
./macos/macos

echo "🍻 Installing brews and casks"
install_brew

echo "🔗 Creating symlinks"
install_symlinks

echo "📦 Configure Node"
configure_node

# Replace the HTTPS remote with `git` when everything is done:
git remote set-url origin git@github.com:basicallydan/dotfiles.git

echo "✅ Successfully installed basicallydan/dotfiles!";

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
        "$HOME/.fnm"
        "$HOME/Code"
        "$HOME/Desktop/Screenshots"
    )

    for i in "${dirs[@]}"; do
        mkdir "$i"
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
    mas install 497799835 # Xcode
    mas install 1545870783 # System Color Picker
    mas install 1672085276 # Aiko
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

echo "🗄 Creating directories"
create_dirs

printf "🛠 Installing Xcode Command Line Tools\n"
build_xcode

echo "🍺 Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

printf "🛍️ Installing Mac App Store apps\n"
install_app_store_apps

echo "💻 Set macOS Preferences"
./macos/.macos

echo "🍻 Installing brews and casks"
install_brew

echo "🔗 Creating symlinks"
install_symlinks

echo "Installing JavaScript tools"
bash ./javascript/node.sh

# echo "Installing ZSH"
# bash ./scripts/install_zsh.sh

# echo "Installing NodeJS, Python, Vim, Atom"
# zsh ./scripts/install_node.sh
# zsh ./scripts/install_python.sh
# zsh ./scripts/install_vim.sh

# echo "Adding necessary symbolic links"
# ln -s ~/dotfiles/git/gitignore ~/.gitignore
# ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
# ln -s ~/dotfiles/dircolors ~/.dircolors

echo "Successfully installed basicallydan/dotfiles!";

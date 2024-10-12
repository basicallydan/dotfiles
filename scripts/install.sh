#!/usr/bin/env bash

# e:          Exit on non-0 exit status
# u:          Exit when undefined variable
# o pipefail: Exit when any pipeline error occurs, no masking
set -euo pipefail

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "🗄 Creating folders"
bash ./setup/folders.sh

echo "🍺 Installing brews and casks"
bash ./setup/brews.sh
bash ./setup/casks.sh

echo "🔗 Creating symlinks"
bash ./setup/symlinks.sh

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

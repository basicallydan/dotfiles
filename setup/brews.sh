#!/usr/bin/env bash

set -euo pipefail

# Makes sure we're on the latest version
brew update
brew upgrade

# Development & general tools
brew install entr

# JS
brew uninstall node --ignore-dependencies

# Core tools
brew install zsh
brew install git

brew install postgresql

# Remove outdated versions from the cellar
brew cleanup


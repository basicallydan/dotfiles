#!/usr/bin/env bash

set -euo pipefail

brew tap homebrew/cask-versions

# Utilities
brew install vlc
brew install dropbox
brew install spotify

# Files etc
brew install dropbox

# Development
brew install iterm2
brew install docker

brew cleanup

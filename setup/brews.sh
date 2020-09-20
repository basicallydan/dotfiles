#!/usr/bin/env bash

set -euo pipefail

# Makes sure we're on the latest version
brew update
brew upgrade
# brew install git-extras
# brew install coreutils
# brew install fswatch
# brew install watchman

# # Network tools
# brew install nmap
# brew install iftop
# brew install bmon
# brew install httpie

# Development & general tools
# Run arbitrary commands when files change http://eradman.com/entrproject/
brew install entr
# brew install htop
# brew install wget
# brew install pstree
# brew install tree
# brew install gcal
# brew install cloc
# brew install ack
# brew install jq
# brew install vim
# brew install ctop

# # Core
# brew install libffi
# brew install ffmpeg

# # Ruby
# brew install ruby

# # Java
# brew install jenv
# brew tap homebrew/cask-versions
# brew cask install java11
# brew cask install java

# # Scala
# brew install sbt

# # JS
brew install Schniz/tap/fnm
brew install yarn
brew uninstall node --ignore-dependencies

# # DevOps
# brew install docker-compose

# # Fonts
# brew tap homebrew/cask-fonts
# brew cask install font-fira-code

# Core tools
brew install zsh
brew install git

# Remove outdated versions from the cellar
brew cleanup


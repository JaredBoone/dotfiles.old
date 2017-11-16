#!/bin/bash

sudo -v

if test ! $(which brew)
then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade
apps=(
    ansible
    git
    wget
    zsh
    zsh-completions
)
brew install "${apps[@]}"
brew cleanup

#!/bin/bash

echo "[brew.sh] - Begin"

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
  mas
)
brew install "${apps[@]}"
brew cleanup


if [ "$(uname)" == "Darwin" ]; then
  # Install Caskroom
  brew tap caskroom/cask
  brew tap caskroom/versions
  # Install packages
  apps=(
      iterm2
      vagrant
      virtualbox
      google-chrome
      keepassxc
      google-backup-and-sync
      firefox
      slack
      skype
      visual-studio-code
  )
  brew cask install "${apps[@]}"
fi

mas install 1091189122 # install Bear writer http://www.bear-writer.com/

echo "[brew.sh] - End"

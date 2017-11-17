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
      keepassxc # Note: Add this to Info.plist: <key>LSUIElement</key>\n<true/>
      google-backup-and-sync
  )
  brew cask install "${apps[@]}"
fi

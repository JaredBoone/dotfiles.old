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
  brew tap JaredBoone/versions

  # Install packages
  apps=(
      iterm2
      java8
      vagrant
      virtualbox
      google-chrome
      macpass
      firefox
      visual-studio-code
      sublime-text
      inboxer
      slack
      malwarebytes
      ccleaner
  )
  brew cask install "${apps[@]}"
fi

mas install 1091189122 # install Bear writer http://www.bear-writer.com/

echo "[brew.sh] - End"

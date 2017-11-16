#!/bin/bash

# Install Caskroom
brew tap caskroom/cask

# Install packages
apps=(
    iterm2
    vagrant
    virtualbox
)

brew cask install "${apps[@]}"

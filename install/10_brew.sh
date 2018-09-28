#!/bin/bash

echo "[brew.sh] - Begin"

if test ! $(which brew)
then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

pushd ../brew
brew update
brew bundle
brew cleanup
popd

echo "[brew.sh] - End"

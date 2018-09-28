#!/bin/bash

echo "[iterm.sh] - Begin"

# Install the Solarized Dark theme for iTerm
# Redundant - already in com.googlecode.iterm2.plist.
# open "${HOME}/dotfiles/iterm/themes/Solarized Dark - Patched.itermcolors"

# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

echo "[iterm.sh] - End"

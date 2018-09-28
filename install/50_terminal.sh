#!/bin/bash

echo "[terminal.sh] - Begin"

# Only use UTF-8 in Terminal.app
#defaults write com.apple.terminal StringEncodings -array 4

# Install the Solarized Dark theme for Terminal
open "${HOME}/dotfiles/terminal/profiles/Solarized Dark ansi.terminal"

echo "[terminal.sh] - End"

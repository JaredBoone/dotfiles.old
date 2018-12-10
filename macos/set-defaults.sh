#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` timestamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Save screenshots to ~/Documents/Screenshots
defaults write com.apple.screencapture location -string "${HOME}/Documents/Screenshots"

# Enable sub-pixel rendering on non-Apple LCDs.
#defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Disable and kill Dashboard
# Can be reverted with:
# defaults write com.apple.dashboard mcx-disabled -boolean NO; killall Dock
defaults write com.apple.dashboard mcx-disabled -boolean YES; killall Dock

# Open text files with sublimetext3 by default
defaults write com.apple.LaunchServices LSHandlers -array-add '{LSHandlerContentType=public.plain-text;LSHandlerRoleAll=com.sublimetext.3;}'

# Set notification banner display time
defaults write com.apple.notificationcenterui bannerTime 3

###############################################################################
# Finder
###############################################################################

# Show the ~/Library folder.
chflags nohidden ~/Library

# Always open everything in Finder's column view.
#defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show hidden files and file extensions by default
#defaults write com.apple.finder AppleShowAllFiles -bool true
#defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable the warning when changing file extensions
#defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Allow text-selection in Quick Look
#defaults write com.apple.finder QLEnableTextSelection -bool true

# Disable the warning before emptying the Trash
#defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Enable auto-correct
#defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Disable Resume system-wide
#defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"


# Show New Windows show folder
defaults write com.apple.finder NewWindowTargetPath "file://$HOME/"

###############################################################################
# Dock
###############################################################################

# Show indicator lights for open applications in the Dock
#defaults write com.apple.dock show-process-indicators -bool true

# Add several spacers
#defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
#defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
#defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
#defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'

# Automatically hide and show the Dock
# defaults write com.apple.dock autohide -bool true

# Do not show recents
defaults write com.apple.dock show-recents -bool false



################
# Calendar
################
defaults write com.apple.iCal "Default duration in minutes for new event" -int 15


###############################################################################
# Do some clean up work.
###############################################################################

for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
           "Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" \
           "Terminal" "Twitter" "iCal"; do
           kill all "${app}" > /dev/null 2>&1
done

# Wait a bit before moving on...
sleep 1

# ...and then.
echo "Success! Defaults are set."
echo "Some changes will not take effect until you reboot your machine."

# See if the user wants to reboot.
function reboot() {
  read -p "Do you want to reboot your computer now? (y/N)" choice
  case "$choice" in
    y | Yes | yes ) echo "Yes"; exit;; # If y | yes, reboot
    n | N | No | no) echo "No"; exit;; # If n | no, exit
    * ) echo "Invalid answer. Enter \"y/yes\" or \"N/no\"" && return;;
  esac
}

# Call on the function
if [[ "Yes" == $(reboot) ]]
then
  echo "Rebooting."
  sudo reboot
  exit 0
else
  exit 1
fi

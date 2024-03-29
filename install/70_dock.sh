#!/bin/bash

echo "[dock.sh] - Begin"

# Remove all apps from the dock
dockutil --list | awk -F"\t" '{print $1}' | while read -r line; do
  dockutil --remove "$line"
done

# Give dock time to restart
sleep 5

# Add Applications folder as a list
dockutil --add '/Applications' --view list --display folder --sort name

echo "[dock.sh] - End"

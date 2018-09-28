#!/bin/bash

# Remove all apps from the dock
dockutil --list | awk -F"\t" '{print $1}' | while read -r line; do
  dockutil --remove "$line"
done

# Give dock time to restart
sleep 1

# Add Applications folder as a list
dockutil --add '/Applications' --view list --display folder
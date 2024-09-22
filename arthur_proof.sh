#!/bin/bash

none=1
mission_control=2
application_windows=3
desktop=4
screen_saver=5
disable_screen_saver=6
display_sleep=10
launchpad=11
notification_centre=12
lock_screen=13
quick_note=14



# Read current hot corner settings
top_left=$(defaults read com.apple.dock wvous-tl-corner)

if [ "$top_left" -eq "$none" ]; then
    # Set hot corners to mission control and application windows
    defaults write com.apple.dock wvous-tl-corner -int $mission_control
    defaults write com.apple.dock wvous-bl-corner -int $application_windows
    echo "Hot corners set to Mission Control (top left) and Application Windows (bottom left)."
else
    # Set all corners to none
    defaults write com.apple.dock wvous-tl-corner -int $none
    defaults write com.apple.dock wvous-bl-corner -int $none
    defaults write com.apple.dock wvous-tr-corner -int $none
    defaults write com.apple.dock wvous-br-corner -int $none
    echo "All hot corners turned off."
fi

# Restart Dock to apply changes
killall Dock

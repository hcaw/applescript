#!/bin/bash

NONE=1
MISSION_CONTROL=2
APPLICATION_WINDOWS=3
DESKTOP=4
SCREEN_SAVER=5
DISABLE_SCREEN_SAVER=6
DISPLAY_SLEEP=10
LAUNCHPAD=11
NOTIFICATION_CENTRE=12
LOCK_SCREEN=13
QUICK_NOTE=14

toggle_hot_corners() {
    # Read current hot corner settings
    top_left=$(defaults read com.apple.dock wvous-tl-corner)

    if [ "$top_left" -eq "$NONE" ]; then
        # Set hot corners to mission control and application windows
        defaults write com.apple.dock wvous-tl-corner -int $MISSION_CONTROL
        defaults write com.apple.dock wvous-bl-corner -int $APPLICATION_WINDOWS
        echo "Hot corners set to Mission Control (top left) and Application Windows (bottom left)."
    else
        # Set all corners to none
        defaults write com.apple.dock wvous-tl-corner -int $NONE
        defaults write com.apple.dock wvous-bl-corner -int $NONE
        defaults write com.apple.dock wvous-tr-corner -int $NONE
        defaults write com.apple.dock wvous-br-corner -int $NONE
        echo "All hot corners turned off."
    fi
}

toggle_hot_corners

# Restart Dock to apply changes
killall Dock

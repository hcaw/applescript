#!/bin/bash

readonly NONE=1
readonly MISSION_CONTROL=2
readonly APPLICATION_WINDOWS=3
readonly DESKTOP=4
readonly SCREEN_SAVER=5
readonly DISABLE_SCREEN_SAVER=6
readonly DISPLAY_SLEEP=10
readonly LAUNCHPAD=11
readonly NOTIFICATION_CENTRE=12
readonly LOCK_SCREEN=13
readonly QUICK_NOTE=14

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

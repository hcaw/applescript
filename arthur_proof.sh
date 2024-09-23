#!/bin/bash
# shellcheck disable=SC2034

toggle_hot_corners() {
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

    top_left=$(defaults read com.apple.dock wvous-tl-corner)

    if [ "$top_left" -eq "$NONE" ]; then
        defaults write com.apple.dock wvous-tl-corner -int $MISSION_CONTROL
        defaults write com.apple.dock wvous-bl-corner -int $APPLICATION_WINDOWS
        echo "Hot corners set to Mission Control (top left) and Application Windows (bottom left)."
    else
        defaults write com.apple.dock wvous-tl-corner -int $NONE
        defaults write com.apple.dock wvous-bl-corner -int $NONE
        defaults write com.apple.dock wvous-tr-corner -int $NONE
        defaults write com.apple.dock wvous-br-corner -int $NONE
        echo "All hot corners turned off."
    fi

    killall Dock
}

# WIP
toggle_trackpad_gestures() {
    swipe_enabled=$(defaults read com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture)

    if [ "$swipe_enabled" -eq 1 ]; then
        # defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 0
        # defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 0
        # Need to disable:
        # - Mission control (four finger swipe up)
        defaults write com.apple.dock showMissionControlGestureEnabled -int 0
        # - App expose (four finger swipe down)
        defaults write com.apple.dock showAppExposeGestureEnabled -int 0
        # - Launchpad (four finger pinch)
        defaults write com.apple.dock showLaunchpadGestureEnabled -int 0
        # - Show desktop (four finger spread)
        defaults write com.apple.dock showDesktopGestureEnabled -int 0
        # - Pinch to zoom
        defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -int 0
        # - Smart zoom (double-tap with two fingers)
        defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -int 0
        # - Rotate (with two fingers)
        defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -int 0
        # - Secondary click with two fingers
        defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerSecondaryClick -int 0
        # - Look up & data detectors (three finger tap)
        defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 0
        # - Swipe between pages (two fingers)
        defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -int 0
        # - Notification Center (two fingers from right edge)
        defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 0

        # Read current settings for trackpad gestures
        defaults read com.apple.dock showMissionControlGestureEnabled
        defaults read com.apple.dock showAppExposeGestureEnabled
        defaults read com.apple.dock showLaunchpadGestureEnabled
        defaults read com.apple.dock showDesktopGestureEnabled
        defaults read com.apple.AppleMultitouchTrackpad TrackpadPinch
        defaults read com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture
        defaults read com.apple.AppleMultitouchTrackpad TrackpadRotate
        defaults read com.apple.AppleMultitouchTrackpad TrackpadTwoFingerSecondaryClick
        defaults read com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture
        defaults read NSGlobalDomain AppleEnableSwipeNavigateWithScrolls
        defaults read com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture

        echo "Trackpad gestures disabled."
    else
        defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 1
        defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 1
        echo "Trackpad gestures enabled."
    fi

    killall SystemUIServer
}

toggle_hot_corners

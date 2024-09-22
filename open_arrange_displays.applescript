-- Open the arrangement setting in the display settings pane of the system settings

on run
    set osver to system version of (system info)

    if osver < 14.0 then
        display dialog "This script only works on macOS 14 or later." buttons {"OK"} default button "OK"
        return
    end if

    set monitorCount to (do shell script "system_profiler SPDisplaysDataType | grep 'Resolution' | wc -l") as integer

    if monitorCount < 2 then
        display dialog "More than one monitor must be present to run this script." buttons {"OK"} default button "OK"
        return
    end if

    open location "x-apple.systempreferences:com.apple.preference.displays"

    tell application "System Settings"
        reveal anchor "arrangementSection" of pane id "com.apple.Displays-Settings.extension"
    end tell
end run

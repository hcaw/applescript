-- Open the arrangement setting in the display setttings pane of the system settings

on run
    set osver to system version of (system info)

    if osver >= 14.0 then
        open location "x-apple.systempreferences:com.apple.preference.displays"

        tell application "System Settings"
            reveal anchor "arrangementSection" of pane id "com.apple.Displays-Settings.extension"
        end tell
    else
        display dialog "This script only works on macOS 14 or later." buttons {"OK"} default button "OK"
    end if
end run

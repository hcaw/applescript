on run
    select_sound_input("hphone Microphone")
    -- tell application "System Settings" to quit
end run

on select_sound_input(input_name)
    set os_version to system version of (system info)

    if os_version < 14.0 then
        display dialog "This script only works on macOS 14 or later." buttons {"OK"} default button "OK"
        return
    end if    

    open location "x-apple.systempreferences:com.apple.Sound-Settings.extension"
    
    tell application "System Settings"
        reveal anchor "Input" of pane id "com.apple.Sound-Settings.extension"
    end tell

    tell application "System Events" to tell process "System Settings"
        set max_attempts to 500
        set attempts to 0
        repeat while attempts < max_attempts
            try
                set mic_outline to outline 1 of scroll area 1 of group 2 of scroll area 1 of group 1 of group 2 of splitter group 1 of group 1 of window 1
                exit repeat
            on error
                log "Unable to find outline on attempt " & (attempts + 1) & " of " & max_attempts
                delay 0.1
                set attempts to attempts + 1
            end try
        end repeat

        if attempts is equal to max_attempts then
            display dialog "Unable to find the microphone input pane after " & max_attempts & " attempts" buttons {"OK"} default button "OK"
            return
        end if

        set row_names to value of static text of group 1 of UI element 1 of every row of mic_outline

        repeat with i from 1 to (count row_names)
            if item i of row_names is equal to {input_name} then
                log (item i of row_names as string) & " found in row " & (i as string)                
                select row i of mic_outline
                return
            end if
        end repeat
        display dialog "Unable to find '" & input_name & "' in input sources" buttons {"OK"} default button "OK"
    end tell
end select_sound_input

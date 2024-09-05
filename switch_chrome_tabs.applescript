-- This script is used to switch between tabs in Google Chrome.
-- I currently have this saved inside in an Apple Shortcut that I can run with a keyboard shortcut.
-- Follow these instructions to get this working with a keyboard shortcut from the Shortcuts app:

-- 1. Open System Settings
-- 2. Click "Privacy & Security"
-- 3. Click "Accessibility"
-- 4. Add & enable "Google Chrome"

-- Also, to get it running I found that I hadto:
-- 1. Enable "Use as Quick Action"
--   1.1. Enable "Services Menu" below
-- 2. Go to Chrome
-- 3. Click "Chrome" in the Menu bar
-- 4. Go to "Services -> Switch Chrome Tabs"
-- This should run the shortcut and you'll see the tabs switch. After this it *should* run by pressing the given shortcut.
on run
	tell application "System Events"
		-- Check if the frontmost application is Google Chrome
		set frontApp to name of first application process whose frontmost is true
		if frontApp is "Google Chrome" then
			-- Simulate pressing Command+Shift+A
			keystroke "a" using {command down, shift down}
			delay 0.1
			-- Simulate pressing Enter
			keystroke return
		end if
	end tell
end run

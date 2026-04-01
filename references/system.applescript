#!/usr/bin/osascript
# System Control Automation Patterns
# Usage: osascript system.applescript <action> [params]

-- ============================================
-- VOLUME CONTROL
-- ============================================

-- Set output volume (0-100)
on setOutputVolume(level)
    set volume output volume level
end tell

-- Get current output volume
on getOutputVolume()
    return output volume of (get volume settings)
end tell

-- Set input volume (0-100)
on setInputVolume(level)
    set volume input volume level
end tell

-- Get current input volume
on getInputVolume()
    return input volume of (get volume settings)
end tell

-- Set alert volume (0-100)
on setAlertVolume(level)
    set volume alert volume level
end tell

-- Mute/unmute
on muteOutput()
    set volume output muted true
end tell

on unmuteOutput()
    set volume output muted false
end tell

-- Get mute status
on isOutputMuted()
    return output muted of (get volume settings)
end tell

-- ============================================
-- BRIGHTNESS CONTROL
-- ============================================

-- Set display brightness (requires third-party tool)
-- Note: Native AppleScript doesn't support brightness directly
-- Use one of these alternatives:

-- Method 1: Using brightness CLI tool (install via brew)
on setBrightness(level)
    do shell script "brightness " & (level as string)
end tell

-- Method 2: Using AppleScript with System Events (limited)
on setBrightnessSystemEvents(level)
    -- This only works on some Mac models
    tell application "System Events"
        -- Brightness keys
        if level > 50 then
            repeat (level - 50) div 10 times
                key code 144 -- F2 (brightness up)
            end repeat
        else
            repeat (50 - level) div 10 times
                key code 122 -- F1 (brightness down)
            end repeat
        end if
    end tell
end tell

-- ============================================
-- DISPLAY SLEEP
-- ============================================

-- Turn off display
on turnOffDisplay()
    tell application "System Events"
        key code 125 using {control down} -- Control+Shift+Eject (or Power)
    end tell
end tell

-- Put computer to sleep
on sleepComputer()
    tell application "System Events" to sleep
end tell

-- Lock screen (macOS 10.10+)
on lockScreen()
    tell application "System Events"
        keystroke "q" using {command down, control down}
    end tell
end tell

-- ============================================
-- POWER MANAGEMENT
-- ============================================

-- Get battery info (for laptops)
on getBatteryInfo()
    try
        set info to do shell script "pmset -g batt | grep -o '[0-9]*%' | tr -d '%'"
        return info as integer
    on error
        return -1
    end try
end tell

-- Check if on battery power
on isOnBattery()
    try
        set powerStatus to do shell script "pmset -g batt | grep -o 'Battery'"
        return powerStatus is not ""
    on error
        return false
    end try
end tell

-- ============================================
-- NOTIFICATIONS
-- ============================================

-- Display notification
on showNotification(theTitle, theSubtitle, theMessage)
    display notification theMessage with title theTitle subtitle theSubtitle
end tell

-- Display notification with sound
on showNotificationWithSound(theTitle, theSubtitle, theMessage, soundName)
    display notification theMessage with title theTitle subtitle theSubtitle sound name soundName
end tell

-- ============================================
-- CLIPBOARD
-- ============================================

-- Copy text to clipboard
on copyToClipboard(theText)
    set the clipboard to theText
end tell

-- Get text from clipboard
on getFromClipboard()
    return the clipboard as text
end tell

-- ============================================
-- DATE & TIME
-- ============================================

-- Get current date and time
on getCurrentDateTime()
    return current date
end tell

-- Get current timestamp (Unix epoch)
on getCurrentTimestamp()
    return do shell script "date +%s"
end tell

-- Format date
on formatDate(theDate)
    return theDate as string
end tell

-- ============================================
-- EXAMPLES
-- ============================================

-- Example: Set volume to 50%
-- setOutputVolume(50)

-- Example: Gradual volume fade in
-- repeat with i from 0 to 50 by 5
--     setOutputVolume(i)
--     delay 0.2
-- end repeat

-- Example: Mute if meeting starts
-- if getCurrentTimestamp() mod 86400 < 32400 then -- before 9 AM
--     muteOutput()
-- end if

-- Example: Battery warning
-- if isOnBattery() and getBatteryInfo() < 20 then
--     showNotification("Low Battery", "Power", "Battery is at " & getBatteryInfo() & "%")
-- end if

-- Example: Copy important info
-- copyToClipboard("Meeting ID: 123-456-789")

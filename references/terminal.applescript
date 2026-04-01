#!/usr/bin/osascript
# Terminal Automation Patterns
# Usage: osascript terminal.applescript <action> [params]

-- ============================================
-- BASIC COMMANDS
-- ============================================

-- Run command in new window
on runCommand(commandString)
    tell application "Terminal"
        activate
        do script commandString
    end tell
end tell

-- Run command in existing window
on runCommandInWindow(commandString, windowIndex)
    tell application "Terminal"
        do script commandString in window windowIndex
    end tell
end tell

-- Run command in specific tab
on runCommandInTab(commandString, windowIndex, tabIndex)
    tell application "Terminal"
        do script commandString in tab tabIndex of window windowIndex
    end tell
end tell

-- ============================================
-- WINDOW & TAB MANAGEMENT
-- ============================================

-- Open new Terminal window
on openNewWindow()
    tell application "Terminal"
        activate
        do script ""
    end tell
end tell

-- Open new tab in first window
on openNewTab()
    tell application "Terminal"
        tell window 1
            create tab with default profile
        end tell
        activate
    end tell
end tell

-- Close specific window
on closeWindow(windowIndex)
    tell application "Terminal"
        close window windowIndex
    end tell
end tell

-- Close all windows
on closeAllWindows()
    tell application "Terminal"
        repeat while (count of windows) > 0
            close first window
        end repeat
    end tell
end tell

-- ============================================
-- GETTING OUTPUT
-- ============================================

-- Get last output from tab (limited)
on getLastOutput(windowIndex, tabIndex)
    tell application "Terminal"
        return content of tab tabIndex of window windowIndex
    end tell
end tell

-- Get selected text from tab
on getSelectedText(windowIndex, tabIndex)
    tell application "Terminal"
        return selected text of tab tabIndex of window windowIndex
    end tell
end tell

-- ============================================
-- PROFILES & SETTINGS
-- ============================================

-- Run command with specific profile
on runCommandWithProfile(commandString, profileName)
    tell application "Terminal"
        do script commandString in tab 1 of window 1 using settings set profileName
    end tell
end tell

-- Set window title
on setWindowTitle(windowIndex, titleString)
    tell application "Terminal"
        set custom title of window windowIndex to titleString
    end tell
end tell

-- ============================================
-- INTERACTIVE COMMANDS
-- ============================================

-- Send keystroke to Terminal
on sendKeystroke(keystrokeString, windowIndex)
    tell application "System Events"
        tell process "Terminal"
            set frontmost to true
            keystroke keystrokeString
        end tell
    end tell
end tell

-- Send special key (Enter, Ctrl+C, etc.)
on sendSpecialKey(keyCode, windowIndex)
    tell application "System Events"
        tell process "Terminal"
            set frontmost to true
            key code keyCode
        end tell
    end tell
end tell

-- Send Ctrl+C to interrupt
on sendInterrupt(windowIndex)
    tell application "System Events"
        tell process "Terminal"
            set frontmost to true
            keystroke "c" using {control down}
        end tell
    end tell
end tell

-- Send Ctrl+D for EOF
on sendEOF(windowIndex)
    tell application "System Events"
        tell process "Terminal"
            set frontmost to true
            keystroke "d" using {control down}
        end tell
    end tell
end tell

-- ============================================
-- UTILITY
-- ============================================

-- Check if Terminal is running
on checkTerminal()
    tell application "System Events"
        return (name of processes) contains "Terminal"
    end tell
end tell

-- Get number of open windows
on countWindows()
    tell application "Terminal"
        return count of windows
    end tell
end tell

-- Get number of tabs in window
on countTabs(windowIndex)
    tell application "Terminal"
        return count of tabs of window windowIndex
    end tell
end tell

-- Activate Terminal (bring to front)
on activateTerminal()
    tell application "Terminal"
        activate
    end tell
end tell

-- ============================================
-- KEY CODES REFERENCE
-- ============================================
-- Return/Enter: 36
-- Tab: 48
-- Space: 49
-- Delete: 51
-- Escape: 53
-- Up Arrow: 126
-- Down Arrow: 125
-- Left Arrow: 123
-- Right Arrow: 124

-- ============================================
-- EXAMPLES
-- ============================================

-- Example: Run ls in new window
-- runCommand("ls -la")

-- Example: Run multiple commands
-- runCommand("cd /Users/jax && git status")

-- Example: Run top in new tab and monitor
-- openNewTab()
-- delay 1
-- runCommandInTab("top -l 1", 1, 2)
-- delay 3
-- set output to getLastOutput(1, 2)

-- Example: Interrupt running process
-- sendInterrupt(1)

-- Example: Set custom title for session
-- runCommand("echo 'Starting build...'")
-- setWindowTitle(1, "Build Session")

-- Example: Run command and get output
-- runCommand("pwd")
-- delay 1
-- set currentDir to getLastOutput(1, 1)

#!/usr/bin/osascript
# Chrome Browser Automation Patterns
# Usage: osascript chrome.applescript <action> [params]

-- ============================================
-- NAVIGATION
-- ============================================

-- Open URL in current tab
on openURL(theURL)
    tell application "Google Chrome"
        tell active tab of first window
            set URL to theURL
        end tell
    end tell
end tell

-- Open URL in new tab
on openInNewTab(theURL)
    tell application "Google Chrome"
        tell first window
            make new tab with properties {URL:theURL}
        end tell
    end tell
end tell

-- Get current URL
on getCurrentURL()
    tell application "Google Chrome"
        tell active tab of first window
            return URL
        end tell
    end tell
end tell

-- ============================================
-- JAVASCRIPT EXECUTION
-- ============================================

-- Execute JS and read result from document.title
on executeJSWithTitle(theJS)
    tell application "Google Chrome"
        tell active tab of first window
            execute javascript "(function(){" & theJS & "})()"
        end tell
    end tell
    delay 2
    tell application "Google Chrome"
        tell active tab of first window
            return title
        end tell
    end tell
end tell

-- Execute JS using JXA (no escaping needed)
on executeJXA(theJS)
    set jsCode to "
    var chrome = Application('Google Chrome');
    var tab = chrome.windows[0].activeTab;
    tab.execute({javascript: " & theJS & "});
    "
    do shell script "osascript -l JavaScript -e '" & jsCode & "'"
end tell

-- ============================================
-- UTILITY
-- ============================================

-- Check if Chrome is controllable
on checkChrome()
    try
        set windowCount to count of windows of application "Google Chrome"
        return windowCount
    on error
        return 0
    end try
end tell

-- Hard restart Chrome
on restartChrome()
    tell application "Google Chrome" to quit
    delay 1
    do shell script "pkill -x 'Google Chrome' 2>/dev/null || true"
    delay 1
    tell application "Google Chrome" to activate
    delay 3
end tell

-- ============================================
-- EXAMPLES
-- ============================================

-- Example: Fetch user data from Reddit
-- executeJSWithTitle("fetch('/api/me.json',{credentials:'include'}).then(r=>r.json()).then(d=>{document.title='R:'+JSON.stringify({name:d.data.name,karma:d.data.total_karma})})")

-- Example: Get page title
-- executeJSWithTitle("document.title")

-- Example: Click element by ID
-- executeJSWithTitle("document.getElementById('myButton').click()")

-- Example: Fill form and submit
-- executeJSWithTitle("document.querySelector('#email').value='test@example.com'; document.querySelector('form').submit()")

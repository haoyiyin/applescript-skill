---
name: applescript
description: Universal AppleScript automation for macOS. Control Chrome, Finder, Mail, Calendar, Messages, Music, Terminal, and any scriptable app. Use when asked to automate macOS apps, control browsers, manage files, send messages, or perform system actions. Triggers on "AppleScript", "osascript", "control Chrome", "automate Mac", or any macOS app automation request.
---

# AppleScript Skill - Universal macOS Automation

Control any scriptable macOS application via AppleScript. Works with Chrome, Finder, Mail, Calendar, Messages, Music, Terminal, and more.

---

## How It Works

```
Claude → osascript → macOS App (native control)
```

- **Native macOS technology** — built into every Mac
- **Direct app control** — no web scraping, no API tokens
- **Uses existing sessions** — logged-in cookies, open windows, current state
- **Undetectable** — apps can't distinguish from human interaction

---

## Prerequisites

- **macOS only** (AppleScript doesn't exist on Windows/Linux)
- For Chrome/Safari: Enable "Allow JavaScript from Apple Events" in Developer menu
- Some apps may require Accessibility permissions

---

## Method Detection (Run First)

Always check if the target app is controllable:

```bash
# Check if app is running
osascript -e 'tell application "System Events" to count processes whose name is "APP_NAME"'

# Check if app has windows (for browsers)
osascript -e 'tell application "APP_NAME" to return count of windows'
```

If count is 0 but app should be open → restart app:

```bash
osascript -e 'tell application "APP_NAME" to quit'
pkill -x "APP_NAME"
sleep 2
open -a "APP_NAME"
sleep 3
```

---

## Quick Reference by App

### Google Chrome / Safari

| Action | Command |
|--------|---------|
| Open URL | `tell app "Chrome" to tell active tab of first window to set URL to "https://..."` |
| Get current URL | `tell app "Chrome" to tell active tab of first window to return URL` |
| Execute JS | `tell app "Chrome" to tell active tab of first window to execute javascript "..."` |
| New window | `tell app "Chrome" to make new window` |
| New tab | `tell app "Chrome" to tell first window to make new tab with URL "..."` |

### Finder

| Action | Command |
|--------|---------|
| Open folder | `tell app "Finder" to open folder "path/to/folder"` |
| Create folder | `tell app "Finder" to make new folder at desktop with properties {name:"Test"}` |
| List files | `tell app "Finder" to get name of every file of folder "path"` |
| Move file | `tell app "Finder" to move file "old" to folder "new"` |
| Delete file | `tell app "Finder" to delete file "path"` |

### Mail

| Action | Command |
|--------|---------|
| Send email | See `references/mail.applescript` |
| Get unread count | `tell app "Mail" to return unread count of inbox` |
| Open mailbox | `tell app "Mail" to open inbox` |

### Messages (iMessage)

| Action | Command |
|--------|---------|
| Send message | `tell app "Messages" to send "Hello" to buddy "contact@email.com"` |
| Open chat | `tell app "Messages" to chat with "contact@email.com"` |

### Music (iTunes)

| Action | Command |
|--------|---------|
| Play | `tell app "Music" to play` |
| Pause | `tell app "Music" to pause` |
| Next track | `tell app "Music" to next track` |
| Set volume | `set volume output volume 50` |

### Terminal

| Action | Command |
|--------|---------|
| Run command | `tell app "Terminal" to do script "ls -la"` |
| New tab | `tell app "Terminal" to tell window 1 to create tab with default profile` |
| Get output | Use `references/terminal.applescript` |

### System

| Action | Command |
|--------|---------|
| Set volume | `set volume output volume 50` |
| Get volume | `get volume settings` |
| Set brightness | Use `references/brightness.applescript` |
| Sleep display | `tell app "System Events" to key code 125 using {control down}` |

---

## Two Methods

### Method 1: Direct AppleScript (Preferred)

Use when app is visible to AppleScript:

```bash
osascript -e 'tell application "Chrome" to tell active tab of first window to set URL to "https://example.com"'
```

### Method 2: System Events (Fallback)

Use when app is not directly controllable (multi-profile Chrome bug):

```bash
osascript -e '
tell application "System Events"
    tell process "Chrome"
        set frontmost to true
        keystroke "l" using {command down}  -- Focus address bar
        delay 0.2
        keystroke "https://example.com"
        delay 0.2
        key code 36  -- Enter
    end tell
end tell'
```

---

## JavaScript Execution (for Browsers)

### Simple JS (no escaping needed with JXA)

```bash
osascript -l JavaScript -e '
var chrome = Application("Google Chrome");
var tab = chrome.windows[0].activeTab;
tab.execute({javascript: "document.title = \"Hello\""});
'
```

### Complex JS with Result (document.title trick)

```bash
# Run JS that writes result to document.title
osascript -e 'tell app "Chrome" to tell active tab of first window to execute javascript "fetch(\"/api/me\").then(r=>r.json()).then(d=>{document.title=\"R:\"+JSON.stringify(d)})"'

# Wait and read title
sleep 2
osascript -e 'tell app "Chrome" to return title of active tab of first window'
```

---

## Error Handling

| Error | Solution |
|-------|----------|
| "Application isn't running" | `open -a "AppName"` first |
| "count of windows = 0" | Hard restart app (quit + pkill + open) |
| "Not authorized" | System Preferences → Privacy → Accessibility |
| JS execution fails | Enable "Allow JavaScript from Apple Events" in browser Dev menu |
| Timeout | Add `with timeout of 30 seconds` wrapper |

---

## Best Practices

1. **Always verify prerequisites** before executing
2. **Use Method 1** when possible (more reliable than keyboard simulation)
3. **Add delays** between rapid actions (0.2-0.5s)
4. **Check app state** before assuming success
5. **Handle multi-profile** Chrome by restarting if windows = 0
6. **Use JXA** (`-l JavaScript`) for complex scripts (avoids escaping hell)

---

## Security Notes

- AppleScript requires user permissions (Accessibility, Automation)
- Apps can see AppleScript events (but can't distinguish from human)
- Never use for malicious automation (spam, fraud, etc.)
- Respect rate limits and terms of service

---

## Examples

See `references/` for complete scripts:
- `references/chrome.applescript` — Browser automation patterns
- `references/finder.applescript` — File management patterns
- `references/mail.applescript` — Email automation patterns
- `references/messages.applescript` — iMessage patterns
- `references/terminal.applescript` — Terminal automation

---

## When to Use This Skill

✅ **Use this skill when:**
- User asks to control a macOS app
- Need to automate browser actions
- Want to send messages, emails, or notifications
- Need to manage files via Finder
- Want to control system settings (volume, brightness)

❌ **Don't use this skill when:**
- On Windows or Linux (use computer-use MCP instead)
- App doesn't support AppleScript (check with `tell app "AppName" to get scriptable`)
- Need visual recognition (use computer-use with screenshots)

---

## Testing Scriptability

Check if an app supports AppleScript:

```bash
osascript -e 'tell application "AppName" to get scriptable'
```

Or open Script Editor → File → Open Dictionary → select app.

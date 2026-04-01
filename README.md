# AppleScript Automation Skill for OpenClaw

🤖 A universal AppleScript automation skill that enables AI agents to control macOS applications through natural language commands.

[中文文档](README.zh.md) | [OpenClaw](https://github.com/openclaw/openclaw) | [Report Issues](https://github.com/openclaw/openclaw/issues)

---

## ✨ Features

- **Browser Automation** — Control Chrome, Safari, Firefox (navigate, execute JS, extract data)
- **File Management** — Finder operations (create, move, copy, delete, organize files)
- **Communication** — Mail & Messages (iMessage) automation
- **System Control** — Volume, brightness, notifications, clipboard, power management
- **Terminal Automation** — Run commands, manage windows/tabs, capture output
- **Media Control** — Music (iTunes), Calendar, Contacts, Reminders

---

## 🚀 Quick Start

### Prerequisites

- macOS 10.15 or later
- [OpenClaw](https://github.com/openclaw/openclaw) installed
- Accessibility permissions enabled (System Settings → Privacy & Security → Accessibility)

### Installation

```bash
# Clone or copy this skill to your OpenClaw workspace
cp -r applescript ~/.openclaw/workspace/skills/
```

### Usage Examples

**Natural Language Commands:**
```
"Open Chrome and visit GitHub"
"Organize all PDFs on my desktop"
"Send iMessage to John saying 'Meeting at 3pm'"
"Set volume to 50%"
"Run ls -la in Terminal"
```

**Direct AppleScript:**
```bash
osascript -e 'tell application "Google Chrome" to set URL of active tab of first window to "https://github.com"'
```

---

## 📁 Structure

```
applescript/
├── SKILL.md                    # Main skill definition
├── README.md                   # English documentation (this file)
├── README.zh.md                # Chinese documentation
├── references/                 # Ready-to-use script templates
│   ├── chrome.applescript      # Browser automation
│   ├── finder.applescript      # File management
│   ├── mail.applescript        # Email automation
│   ├── messages.applescript    # iMessage automation
│   ├── system.applescript      # System control
│   └── terminal.applescript    # Terminal automation
└── scripts/                    # Custom automation scripts
```

---

## 📖 Documentation

### Supported Applications

| Category | Applications |
|----------|-------------|
| **Browsers** | Chrome, Safari, Firefox |
| **File System** | Finder |
| **Communication** | Mail, Messages (iMessage) |
| **System** | Volume, Brightness, Notifications, Clipboard |
| **Development** | Terminal, VS Code |
| **Media** | Music (iTunes), QuickTime |
| **Productivity** | Calendar, Contacts, Reminders, Notes |

### Example Workflows

#### 1. Browser Automation
```applescript
tell application "Google Chrome"
    tell active tab of first window
        set URL to "https://github.com/trending"
        delay 2
        return title
    end tell
end tell
```

#### 2. File Organization
```applescript
tell application "Finder"
    set desktopFiles to every item of desktop whose name ends with ".pdf"
    repeat with file in desktopFiles
        move file to folder "Documents" of home folder
    end repeat
end tell
```

#### 3. Send Message
```applescript
tell application "Messages"
    set theBuddy to buddy "contact@example.com" of (service 1 whose service type is iMessage)
    send "Hello! Are you free?" to theBuddy
end tell
```

---

## 🔧 Configuration

### Enable Accessibility Permissions

1. Open **System Settings** → **Privacy & Security** → **Accessibility**
2. Click the **+** button
3. Add these applications:
   - `Google Chrome` (or your browser)
   - `Terminal`
   - `Messages`
   - `Mail`

### Grant Automation Permissions

1. Open **System Settings** → **Privacy & Security** → **Automation**
2. Enable permissions for:
   - `System Events`
   - `Finder`
   - `Messages`
   - `Mail`

---

## 🛡️ Security Considerations

- AppleScript can control your entire Mac — only run scripts from trusted sources
- Review scripts before execution, especially those that:
  - Delete or move files
  - Send messages or emails
  - Execute terminal commands
- This skill runs locally — no data is sent to external servers

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This skill is part of the OpenClaw project and follows the same license.

---

## 🔗 Links

- [OpenClaw Documentation](https://docs.openclaw.ai)
- [AppleScript Language Guide](https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/introduction/ASLR_intro.html)
- [macOS Automation Community](https://macscripter.net/)

---

**Made with ❤️ for the OpenClaw community**

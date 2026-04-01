# AppleScript Automation Skill

🤖 A universal AppleScript automation toolkit that enables AI agents and developers to control macOS applications through natural language commands or direct script execution.

**Agent-Agnostic** — Works with any AI agent framework (OpenClaw, Claude Code, Cursor, Codex, or standalone)

[中文文档](README.zh.md) · [Report Issues](https://github.com/haoyiyin/applescript-skill/issues)

---

## ✨ Features

- **🌐 Browser Automation** — Control Chrome, Safari, Firefox (navigate, execute JS, extract data)
- **📁 File Management** — Finder operations (create, move, copy, delete, organize files)
- **💬 Communication** — Mail & Messages (iMessage) automation
- **⚙️ System Control** — Volume, brightness, notifications, clipboard, power management
- **💻 Terminal Automation** — Run commands, manage windows/tabs, capture output
- **🎵 Media Control** — Music (iTunes), Calendar, Contacts, Reminders

---

## 🚀 Quick Start

### Prerequisites

- macOS 10.15 or later
- Accessibility permissions enabled (System Settings → Privacy & Security → Accessibility)

### Installation

```bash
# Clone the repository
git clone https://github.com/haoyiyin/applescript-skill.git
cd applescript-skill
```

### Usage Examples

**With AI Agents:**
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

**From Python:**
```python
import subprocess

def run_applescript(script):
    result = subprocess.run(['osascript', '-e', script], capture_output=True, text=True)
    return result.stdout

run_applescript('tell application "Finder" to return name of every item of desktop')
```

**From Node.js:**
```javascript
const { execSync } = require('child_process');

function runAppleScript(script) {
    return execSync(`osascript -e '${script}'`, { encoding: 'utf8' });
}

console.log(runAppleScript('tell application "Finder" to return count of every item of desktop'));
```

---

## 📁 Structure

```
applescript-skill/
├── SKILL.md                    # Agent skill definition (OpenClaw format)
├── README.md                   # English documentation (this file)
├── README.zh.md                # Chinese documentation
├── LICENSE                     # MIT License
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

#### 4. System Control
```applescript
-- Set volume to 50%
set volume output volume 50

-- Copy to clipboard
set the clipboard to "Hello, World!"

-- Display notification
display notification "Task completed!" with title "Automation"
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
   - Your AI agent application (if applicable)

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
  - Access sensitive data
- Scripts run locally — no data is sent to external servers unless explicitly coded

---

## 🤝 Integration with AI Agents

### OpenClaw
```bash
# Copy to OpenClaw workspace
cp -r applescript-skill ~/.openclaw/workspace/skills/applescript/
```

### Claude Code / Cursor / Codex
Reference the `references/` scripts directly in your prompts:
```
Use the AppleScript skill to open Chrome and navigate to GitHub.
Reference: ./applescript-skill/references/chrome.applescript
```

### Custom Agents
Implement AppleScript execution in your agent's tool layer:
```python
def execute_applescript_file(path):
    result = subprocess.run(['osascript', path], capture_output=True, text=True)
    return {'output': result.stdout, 'error': result.stderr}
```

---

## 📄 License

MIT License — See [LICENSE](LICENSE) file for details.

---

## 🔗 Resources

- [AppleScript Language Guide](https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/introduction/ASLR_intro.html)
- [macOS Automation Community](https://macscripter.net/)
- [AppleScript Essentials](https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptingBasic/)

---

**Built with ❤️ for the AI agent community**

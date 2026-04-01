# AppleScript 自动化技能

🤖 一个通用的 AppleScript 自动化工具包，让 AI 代理和开发者能够通过自然语言命令或直接脚本执行来控制 macOS 应用程序。

**与 Agent 无关** — 适用于任何 AI 代理框架（OpenClaw、Claude Code、Cursor、Codex 或独立使用）

[English Documentation](README.md) · [问题反馈](https://github.com/haoyiyin/applescript-skill/issues)

---

## ✨ 功能特性

- **🌐 浏览器自动化** — 控制 Chrome、Safari、Firefox（导航、执行 JS、提取数据）
- **📁 文件管理** — Finder 操作（创建、移动、复制、删除、整理文件）
- **💬 通讯自动化** — 邮件和 iMessage 自动化
- **⚙️ 系统控制** — 音量、亮度、通知、剪贴板、电源管理
- **💻 Terminal 自动化** — 运行命令、管理窗口/标签页、捕获输出
- **🎵 媒体控制** — Music (iTunes)、日历、联系人、提醒事项

---

## 🚀 快速开始

### 前置要求

- macOS 10.15 或更高版本
- 已启用辅助功能权限（系统设置 → 隐私与安全性 → 辅助功能）

### 安装

```bash
# 克隆仓库
git clone https://github.com/haoyiyin/applescript-skill.git
cd applescript-skill
```

### 使用示例

**配合 AI 代理：**
```
"打开 Chrome 访问 GitHub"
"整理桌面上的所有 PDF 文件"
"给张三发 iMessage 说'下午 3 点开会'"
"把音量调到 50%"
"在 Terminal 里运行 ls -la"
```

**直接使用 AppleScript：**
```bash
osascript -e 'tell application "Google Chrome" to set URL of active tab of first window to "https://github.com"'
```

**Python 调用：**
```python
import subprocess

def run_applescript(script):
    result = subprocess.run(['osascript', '-e', script], capture_output=True, text=True)
    return result.stdout

run_applescript('tell application "Finder" to return name of every item of desktop')
```

**Node.js 调用：**
```javascript
const { execSync } = require('child_process');

function runAppleScript(script) {
    return execSync(`osascript -e '${script}'`, { encoding: 'utf8' });
}

console.log(runAppleScript('tell application "Finder" to return count of every item of desktop'));
```

---

## 📁 目录结构

```
applescript-skill/
├── SKILL.md                    # Agent 技能定义（OpenClaw 格式）
├── README.md                   # 英文文档
├── README.zh.md                # 中文文档（本文件）
├── LICENSE                     # MIT 许可证
├── references/                 # 即拿即用的脚本模板
│   ├── chrome.applescript      # 浏览器自动化
│   ├── finder.applescript      # 文件管理
│   ├── mail.applescript        # 邮件自动化
│   ├── messages.applescript    # iMessage 自动化
│   ├── system.applescript      # 系统控制
│   └── terminal.applescript    # Terminal 自动化
└── scripts/                    # 自定义自动化脚本
```

---

## 📖 文档

### 支持的应用程序

| 类别 | 应用程序 |
|------|---------|
| **浏览器** | Chrome, Safari, Firefox |
| **文件系统** | Finder |
| **通讯** | Mail, Messages (iMessage) |
| **系统** | 音量、亮度、通知、剪贴板 |
| **开发** | Terminal, VS Code |
| **媒体** | Music (iTunes), QuickTime |
| **生产力** | Calendar, Contacts, Reminders, Notes |

### 示例工作流

#### 1. 浏览器自动化
```applescript
tell application "Google Chrome"
    tell active tab of first window
        set URL to "https://github.com/trending"
        delay 2
        return title
    end tell
end tell
```

#### 2. 文件整理
```applescript
tell application "Finder"
    set desktopFiles to every item of desktop whose name ends with ".pdf"
    repeat with file in desktopFiles
        move file to folder "Documents" of home folder
    end repeat
end tell
```

#### 3. 发送消息
```applescript
tell application "Messages"
    set theBuddy to buddy "contact@example.com" of (service 1 whose service type is iMessage)
    send "你好！有空吗？" to theBuddy
end tell
```

#### 4. 系统控制
```applescript
-- 设置音量为 50%
set volume output volume 50

-- 复制到剪贴板
set the clipboard to "Hello, World!"

-- 显示通知
display notification "任务完成！" with title "自动化"
```

---

## 🔧 配置

### 启用辅助功能权限

1. 打开 **系统设置** → **隐私与安全性** → **辅助功能**
2. 点击 **+** 按钮
3. 添加这些应用程序：
   - `Google Chrome`（或你的浏览器）
   - `Terminal`
   - `Messages`
   - `Mail`
   - 你的 AI 代理应用（如适用）

### 授予自动化权限

1. 打开 **系统设置** → **隐私与安全性** → **自动化**
2. 启用以下权限：
   - `System Events`
   - `Finder`
   - `Messages`
   - `Mail`

---

## 🛡️ 安全考虑

- AppleScript 可以控制你的整个 Mac — 只运行来自可信来源的脚本
- 在执行前审查脚本，特别是那些：
   - 删除或移动文件的
   - 发送消息或邮件的
   - 执行终端命令的
   - 访问敏感数据的
- 脚本在本地运行 — 除非明确编码，否则不会将数据发送到外部服务器

---

## 🤝 与 AI 代理集成

### OpenClaw
```bash
# 复制到 OpenClaw 工作区
cp -r applescript-skill ~/.openclaw/workspace/skills/applescript/
```

### Claude Code / Cursor / Codex
在你的 prompt 中直接引用 `references/` 脚本：
```
使用 AppleScript 技能打开 Chrome 并导航到 GitHub。
参考：./applescript-skill/references/chrome.applescript
```

### 自定义 Agent
在你的 agent 工具层实现 AppleScript 执行：
```python
def execute_applescript_file(path):
    result = subprocess.run(['osascript', path], capture_output=True, text=True)
    return {'output': result.stdout, 'error': result.stderr}
```

---

## 💡 实用场景

### 日常工作
- 自动打开工作相关的网页（邮箱、日历、任务管理）
- 整理下载文件夹
- 批量重命名文件
- 自动发送日报/周报邮件

### 开发工作
- 自动运行测试脚本
- 查看日志文件
- 管理 git 仓库
- 快速切换开发环境

### 生活助手
- 发送定时消息
- 整理照片
- 控制音乐播放
- 创建提醒事项

---

## ❓ 常见问题

### Q: 为什么 AppleScript 无法控制 Chrome？
A: 确保：
1. Chrome 已授予辅助功能权限
2. Chrome 已打开（至少有一个窗口）
3. macOS 版本兼容

### Q: 如何调试 AppleScript？
A: 使用 `Script Editor` 应用（macOS 自带）：
1. 打开 Script Editor
2. 粘贴脚本
3. 点击运行查看结果和错误信息

### Q: 可以控制 Windows 应用吗？
A: 不行，AppleScript 仅适用于 macOS。Windows 用户可以考虑使用 PowerShell 或 AutoHotkey。

### Q: 如何在 CI/CD 中使用？
A: 不推荐在 CI/CD 中使用 AppleScript，因为它需要 GUI 访问权限。考虑使用纯命令行工具替代。

---

## 📄 许可证

MIT 许可证 — 详见 [LICENSE](LICENSE) 文件。

---

## 🔗 资源

- [AppleScript 语言指南](https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/introduction/ASLR_intro.html)
- [macOS 自动化社区](https://macscripter.net/)
- [AppleScript 基础教程](https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptingBasic/)

---

**为 AI 代理社区打造 ❤️**

# 🖥️ RetroBash OS

**RetroBash OS** is a lightweight, simulated Desktop Environment (DE) and Operating System interface written entirely in Bash. It brings the nostalgia of retro BIOS screens and text-based user interfaces (TUI) directly to your modern terminal.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Bash](https://img.shields.io/badge/language-Bash-green.svg)

## ✨ Features

* **Two Modes:**
    * **Basic Mode:** Pure ASCII art and keyboard input. No external dependencies.
    * **GUI Mode:** Full mouse support, clickable menus, and windows (powered by `dialog`).
* **Built-in Applications:**
    * 🧮 Calculator (supports decimals)
    * 📂 File Browser
    * ℹ️ System Information Dashboard
    * 📝 Text Editor Integration (Nano/Vim)
* **Modular Design:** Easily extensible function-based architecture. Add your own apps in minutes.

---

## 🚀 Getting Started

### Prerequisites

**For the Basic Version (`os_ascii.sh`):**
* Standard Bash environment (Linux, macOS, WSL).
* `bc` (Basic Calculator) - usually installed by default.

**For the Mouse/GUI Version (`os_gui.sh`):**
* You must have **`dialog`** installed to render the windows and capture mouse clicks.

#### Installing Dependencies

**Ubuntu / Debian / Kali:**
```bash
sudo apt update
sudo apt install dialog bc

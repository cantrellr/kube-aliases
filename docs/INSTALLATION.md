# ✈️ Installation Guide

This guide covers all installation methods for kube-aliases on Windows.

---

## 📋 Prerequisites

Before installing, ensure you have:

- **Windows 10/11** or Windows Server 2016+
- **PowerShell 5.1+** (included with Windows)
- **kubectl** installed and configured - [Install Guide](https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/)
- **Optional:** [kubectx + kubens](https://github.com/ahmetb/kubectx) for enhanced context switching

### Verify Prerequisites

```powershell
# Check PowerShell version (should be 5.1+)
$PSVersionTable.PSVersion

# Check kubectl is installed
kubectl version --client

# Check kubectl can connect to a cluster (optional)
kubectl cluster-info
```

---

## 🚀 Quick Install (Recommended)

### Option 1: Git Clone

```cmd
# Clone the repository
git clone https://github.com/cantrellr/kube-aliases.git D:\DevTools\kube-aliases

# Run the installer (as Administrator for best results)
D:\DevTools\kube-aliases\install.cmd
```

### Option 2: Download ZIP

1. Download from [GitHub Releases](https://github.com/cantrellr/kube-aliases/releases)
2. Extract to `D:\DevTools\kube-aliases`
3. Run `install.cmd`

---

## 🔧 Manual Installation

If you prefer manual control or the automatic installer doesn't work:

### PowerShell Setup

1. **Create the script directory** (if needed):
   ```powershell
   New-Item -ItemType Directory -Path "D:\DevTools\kube-aliases" -Force
   ```

2. **Copy the PowerShell script** or run the installer once to generate it

3. **Add to your PowerShell profile**:
   ```powershell
   # Open your profile in notepad
   notepad $PROFILE
   
   # Add this line at the end:
   . "D:\DevTools\kube-aliases\kube-profile.ps1"
   ```

4. **Reload your profile**:
   ```powershell
   . $PROFILE
   ```

### CMD Setup

1. **Open Registry Editor** (`regedit`)

2. **Navigate to:**
   ```
   HKEY_CURRENT_USER\Software\Microsoft\Command Processor
   ```

3. **Create or modify** the `AutoRun` string value:
   ```
   "D:\DevTools\kube-aliases\kube-aliases.cmd"
   ```

4. **Open a new CMD window** to test

---

## ✅ Verify Installation

### PowerShell

```powershell
# Open a NEW PowerShell window, then:

# Check if aliases loaded
kh

# Test a basic alias
kgn  # Should list nodes if connected to a cluster

# Check context info
kinfo
```

### CMD

```cmd
# Open a NEW CMD window, then:

# Check if aliases loaded
kh

# Test a basic alias
kgn
```

---

## 🔄 Updating

To update to the latest version:

```cmd
# If installed via git
cd D:\DevTools\kube-aliases
git pull

# Re-run installer to regenerate scripts
install.cmd
```

---

## 🗑️ Uninstalling

### Automatic

```cmd
# Coming soon: uninstall.cmd
```

### Manual

1. **Remove from PowerShell profile**:
   ```powershell
   notepad $PROFILE
   # Remove the line containing "kube-profile.ps1"
   ```

2. **Remove registry entry** (CMD):
   - Open `regedit`
   - Navigate to `HKCU\Software\Microsoft\Command Processor`
   - Delete or modify the `AutoRun` value

3. **Delete the installation folder**:
   ```powershell
   Remove-Item -Recurse -Force "D:\DevTools\kube-aliases"
   ```

---

## 🐛 Troubleshooting

### PowerShell Execution Policy Error

If you get an execution policy error:

```powershell
# Set policy for current user (recommended)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Or bypass for this session only
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```

### Aliases Not Loading

1. **Check your profile path:**
   ```powershell
   $PROFILE
   # Verify the file exists
   Test-Path $PROFILE
   ```

2. **Check profile content:**
   ```powershell
   Get-Content $PROFILE
   # Should contain: . "D:\DevTools\kube-aliases\kube-profile.ps1"
   ```

3. **Manually load and check for errors:**
   ```powershell
   . "D:\DevTools\kube-aliases\kube-profile.ps1"
   ```

### CMD Aliases Not Loading

1. **Check registry:**
   ```cmd
   reg query "HKCU\Software\Microsoft\Command Processor" /v AutoRun
   ```

2. **Manually load:**
   ```cmd
   "D:\DevTools\kube-aliases\kube-aliases.cmd"
   ```

### kubectl Not Found

Ensure kubectl is in your PATH:

```powershell
# Check if kubectl is available
Get-Command kubectl

# If not found, add to PATH or install:
# https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/
```

---

## 📁 Installation Directory Structure

After installation:

```
D:\DevTools\kube-aliases\
├── install.cmd              # Installer script
├── kube-profile.ps1         # Generated PowerShell aliases
├── kube-aliases.cmd         # Generated CMD aliases
├── kube-aliases-cheatsheet.html  # Printable reference
├── README.md
└── ...
```

---

## 💡 Tips

1. **Run installer as Administrator** for automatic registry configuration
2. **Restart terminals** after installation for changes to take effect
3. **Use `kinfo`** to verify your current context before running commands
4. **Type `kh`** anytime to see all available aliases

---

*Need help? [Open an issue](https://github.com/cantrellr/kube-aliases/issues) on GitHub.*

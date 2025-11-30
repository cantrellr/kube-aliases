# Contributing to kube-aliases

First off, thanks for taking the time to contribute! ✈️

This project welcomes contributions from the K8s community. Whether you're fixing a bug, adding a new alias, or improving documentation, your help is appreciated.

## ✈️ Pre-Flight Checklist

Before contributing, please:

1. **Check existing issues** - Someone may have already reported the bug or requested the feature
2. **Search pull requests** - Your contribution might already be in progress
3. **Read this guide** - It'll help your contribution land smoothly

## 🛫 How to Contribute

### Reporting Bugs

Found a bug? File an issue with:

- **Clear title** - Describe the problem concisely
- **Steps to reproduce** - How can we replicate the issue?
- **Expected behavior** - What should happen?
- **Actual behavior** - What actually happens?
- **Environment** - Windows version, PowerShell version, kubectl version

### Suggesting Features

Have an idea? We'd love to hear it! Open an issue with:

- **Use case** - Why is this feature needed?
- **Proposed solution** - How would it work?
- **Alternatives considered** - Any other approaches?

### Submitting Pull Requests

Ready to contribute code? Here's the flight plan:

1. **Fork the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/kube-aliases.git
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/awesome-alias
   ```

3. **Make your changes**
   - Follow existing code style
   - Test on both PowerShell and CMD if applicable
   - Update documentation if needed

4. **Commit with a clear message**
   ```bash
   git commit -m "Add alias for kubectl top nodes by CPU"
   ```

5. **Push and create a PR**
   ```bash
   git push origin feature/awesome-alias
   ```

## 📋 Code Style Guidelines

### PowerShell Functions

```powershell
# Use descriptive function names
function kgp { kubectl get pods $args }

# Add comments for complex functions
function kxpod {
    param(
        [Parameter(Mandatory=$true)]
        [string] $NamePrefix,
        [string] $Shell = "/bin/bash"
    )
    # Implementation...
}
```

### CMD DOSKEY Macros

```cmd
REM Use consistent formatting
doskey kgp=kubectl.exe get pods $*

REM Group related aliases with comments
REM ============================================
REM RESOURCES
REM ============================================
```

## 🎯 Contribution Ideas

Looking for ways to help? Here are some ideas:

- [ ] Add Helm command aliases (`h`, `hi`, `hu`, `hls`, etc.)
- [ ] Add Argo CD aliases
- [ ] Add Istio aliases
- [ ] Improve error handling in PowerShell functions
- [ ] Add bash/zsh version for Linux/macOS
- [ ] Add tab completion enhancements
- [ ] Create installation script for Chocolatey/Scoop
- [ ] Add more PowerShell helper functions

## ✅ Pull Request Checklist

Before submitting your PR, ensure:

- [ ] Code follows existing style
- [ ] Tested on PowerShell 5.1+
- [ ] Tested on CMD (if applicable)
- [ ] README updated (if adding new aliases)
- [ ] CHANGELOG updated
- [ ] No breaking changes (or clearly documented)

## 🤝 Code of Conduct

Be respectful and professional. We're all here to make K8s easier to use. Harassment, trolling, or unconstructive criticism won't fly here.

## 📜 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thanks for helping make kube-aliases better! ⎈

*"In the world of Kubernetes, aliases are the autopilot that keeps you on course."*

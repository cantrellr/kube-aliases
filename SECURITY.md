# Security Policy

## ✈️ Security First

While kube-aliases is a collection of shell shortcuts and doesn't handle sensitive data directly, we take security seriously.

## 🛡️ What This Project Does

- Creates PowerShell functions and CMD DOSKEY macros
- Modifies your PowerShell profile (user-level)
- Adds a registry entry to `HKCU\Software\Microsoft\Command Processor\AutoRun` (user-level only)

## ⚠️ What This Project Does NOT Do

- Store or transmit any credentials
- Access your kubeconfig secrets
- Make network requests
- Collect telemetry or analytics
- Require administrator privileges (though recommended for best experience)

## 🔒 Security Considerations

### Registry Modifications

The installer adds an AutoRun entry at the **user level** (`HKCU`), not system-wide (`HKLM`). This means:
- Only affects your user account
- No elevated privileges required
- Easy to remove if needed

### Script Execution

PowerShell execution policy may need adjustment:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

We recommend `RemoteSigned` rather than `Unrestricted` for security.

## 🚨 Reporting a Vulnerability

If you discover a security vulnerability, please:

1. **DO NOT** open a public issue
2. Email the maintainer directly or use GitHub's private vulnerability reporting
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

We'll respond within 48 hours and work with you to understand and address the issue.

## ✅ Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | ✅ Yes             |

## 📋 Best Practices for Users

1. **Review scripts before running** - Always inspect `install.cmd` before execution
2. **Use RemoteSigned policy** - Don't use `Unrestricted` execution policy
3. **Keep kubectl updated** - Ensure you're running a supported kubectl version
4. **Verify context before destructive commands** - Use `kinfo` before `krm`

---

*"Security is not a destination, it's a journey. Fly safe!"* ✈️🔒

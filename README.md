# ⎈ Kubernetes Aliases for Windows

> *Because life's too short to type `kubectl get pods --all-namespaces`*

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Windows-0078D6.svg)](https://www.microsoft.com/windows)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-5391FE.svg)](https://docs.microsoft.com/powershell/)
[![kubectl](https://img.shields.io/badge/kubectl-required-326CE5.svg)](https://kubernetes.io/docs/tasks/tools/)

A comprehensive collection of kubectl aliases for **PowerShell** and **CMD** that will save you thousands of keystrokes and mass amounts of time. 🚀

---

## 📦 Installation

### Quick Install

```cmd
# Clone the repository
git clone https://github.com/YOUR_USERNAME/kube-aliases.git D:\DevTools\kube-aliases

# Run the installer (as Administrator recommended)
D:\DevTools\kube-aliases\install.cmd
```

### What the Installer Does

1. ✅ Creates the installation directory
2. ✅ Generates PowerShell aliases script (`kube-profile.ps1`)
3. ✅ Generates CMD aliases script (`kube-aliases.cmd`)
4. ✅ Updates your PowerShell profile to auto-load aliases
5. ✅ Configures CMD AutoRun registry for auto-load

### Manual Installation

If you prefer manual setup:

**PowerShell:**
```powershell
# Add to your $PROFILE
. "D:\DevTools\kube-aliases\kube-profile.ps1"
```

**CMD:**
```cmd
# Add to HKCU\Software\Microsoft\Command Processor\AutoRun
"D:\DevTools\kube-aliases\kube-aliases.cmd"
```

---

## 🎯 Aliases Cheat Sheet

### ⚡ Core & Verbs
*The basics that'll save your sanity*

| Alias | Command | Description |
|-------|---------|-------------|
| `k` | `kubectl` | **MVP** - The one alias to rule them all |
| `kg` | `kubectl get` | Get resources |
| `kd` | `kubectl describe` | Describe resources |
| `ke` | `kubectl edit` | Edit resources |
| `ka` | `kubectl apply` | Apply configuration |
| `kc` | `kubectl create` | Create resources |
| `krm` | `kubectl delete` | ⚠️ Delete resources |
| `kl` | `kubectl logs` | View logs |
| `kx` | `kubectl exec` | Execute commands |

### 📦 Resources
*Get all the things!*

| Alias | Command | Description |
|-------|---------|-------------|
| `kgp` | `kubectl get pods` | 🔥 Most used! |
| `kgd` | `kubectl get deployments` | List deployments |
| `kgs` | `kubectl get svc` | List services |
| `kgn` | `kubectl get nodes` | List nodes |
| `kgi` | `kubectl get ingress` | List ingresses |
| `kga` | `kubectl get all` | List all resources |
| `kgpa` | `kubectl get pods --all-namespaces` | Pods across all namespaces |
| `kgaa` | `kubectl get all --all-namespaces` | Everything everywhere |

### 👀 Watch & Logs
*Stare at pods like they're Netflix*

| Alias | Command | Description |
|-------|---------|-------------|
| `kgpw` | `kubectl get pods -w` | Watch pods |
| `kgdw` | `kubectl get deployments -w` | Watch deployments |
| `klo` | `kubectl logs -f` | 🔥 Follow logs |
| `kexec` | `kubectl exec -it` | Interactive exec |
| `kpf` | `kubectl port-forward` | Port forwarding |

### 🔍 Describe Helpers
*When "it's not working" isn't helpful*

| Alias | Command | Description |
|-------|---------|-------------|
| `kdp` | `kubectl describe pod` | Describe pod |
| `kdd` | `kubectl describe deployment` | Describe deployment |
| `kds` | `kubectl describe service` | Describe service |
| `kdsec` | `kubectl describe secret` | Describe secret |
| `kdcm` | `kubectl describe configmap` | Describe configmap |

### 📄 Output Formats
*YAML: Yet Another Markup Langua- \*cries\**

| Alias | Command | Description |
|-------|---------|-------------|
| `kgy` | `kubectl get -o yaml` | YAML output |
| `kgj` | `kubectl get -o json` | JSON output |
| `kgw` | `kubectl get -o wide` | Wide output |

### 🔐 Secrets & ConfigMaps
*Base64 is NOT encryption, folks*

| Alias | Command | Description |
|-------|---------|-------------|
| `kgsec` | `kubectl get secrets` | List secrets |
| `kgcm` | `kubectl get configmaps` | List configmaps |

### 📁 File Operations
*Apply all the YAMLs!*

| Alias | Command | Description |
|-------|---------|-------------|
| `kaf` | `kubectl apply -f` | 🔥 Apply from file |
| `kdf` | `kubectl delete -f` | ⚠️ Delete from file |

### 🔄 Rollout & Scale
*Scale to infinity... and your cloud bill*

| Alias | Command | Description |
|-------|---------|-------------|
| `krollout` | `kubectl rollout status` | Check rollout status |
| `krestart` | `kubectl rollout restart` | Restart deployment |
| `kscale` | `kubectl scale` | Scale resources |

### 🖥️ Node Operations
*Treat your nodes like cattle, not pets*

| Alias | Command | Description |
|-------|---------|-------------|
| `kdrain` | `kubectl drain` | ⚠️ Drain node |
| `kunc` | `kubectl uncordon` | Uncordon node |
| `kcord` | `kubectl cordon` | Cordon node |

### 📊 Metrics & Events
*Who's eating all the CPU?*

| Alias | Command | Description |
|-------|---------|-------------|
| `ktop` | `kubectl top pods` | Pod metrics |
| `ktopn` | `kubectl top nodes` | Node metrics |
| `kev` | `kubectl get events --sort-by=.lastTimestamp` | Sorted events |

### 🎯 Context & Namespace
*Don't deploy to prod... again*

| Alias | Command | Description |
|-------|---------|-------------|
| `kx` | `kubectx` / `kubectl config use-context` | Switch context |
| `kn` | `kubens` / `kubectl config set-context` | Switch namespace |
| `kinfo` | *(function)* | Show current context info |

### 🧩 CRDs & API
*Extending K8s like it's Lego*

| Alias | Command | Description |
|-------|---------|-------------|
| `kgc` | `kubectl get crd` | List CRDs |
| `kap` | `kubectl api-resources` | List API resources |
| `kav` | `kubectl api-versions` | List API versions |

---

## 🎩 PowerShell-Only Magic Functions

These advanced functions are only available in PowerShell:

```powershell
# Tail logs with optional container name
klogs <pod> [container]

# Exec into pod by name prefix (fuzzy match!)
kxpod <prefix> [shell]

# Display current context, namespace & cluster URL
kinfo

# Show help
kh
```

---

## 💡 Pro Tips for Survival

1. **Always run `kinfo` before doing anything destructive.** Trust no one, not even yourself.

2. **Chain commands** to find troubled pods:
   ```powershell
   kgp | Select-String -Pattern "Error|CrashLoop"
   ```

3. **Use `kgpw` when deploying** - it's like watching paint dry, but more stressful.

4. **`kev` is your best friend** when debugging. Events don't lie (usually).

5. **Remember:** `krm` in prod is a career-limiting move. Double-check that context! 😅

---

## 😂 K8s Dev Lifecycle

```
┌─────────────────────────────────────────────────────────────┐
│  Monday:    kgp → 0/1 CrashLoopBackOff 😱                   │
│  Tuesday:   kdp my-pod → ImagePullBackOff 🤦                │
│  Wednesday: kev → FailedScheduling: 0/3 nodes 💀            │
│  Thursday:  klo my-pod → "it works on my machine" 🤷        │
│  Friday:    krm -f . --force 🔥🔥🔥                         │
└─────────────────────────────────────────────────────────────┘
```

---

## 📋 Requirements

- **Windows 10/11** or Windows Server 2016+
- **PowerShell 5.1+** (comes with Windows)
- **kubectl** - [Install Guide](https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/)
- **Optional:** [kubectx + kubens](https://github.com/ahmetb/kubectx) for enhanced context/namespace switching

---

## 🗂️ Files

```
kube-aliases/
├── install.cmd              # Installer script
├── kube-profile.ps1         # PowerShell aliases (generated)
├── kube-aliases.cmd         # CMD aliases (generated)
├── kube-aliases-cheatsheet.html  # Printable cheat sheet
├── README.md                # You are here!
├── LICENSE                  # MIT License
└── .gitignore               # Git ignore file
```

---

## 🤝 Contributing

Contributions are welcome! Feel free to:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/awesome-alias`)
3. Commit your changes (`git commit -m 'Add awesome alias'`)
4. Push to the branch (`git push origin feature/awesome-alias`)
5. Open a Pull Request

### Ideas for Contributions

- [ ] Add more aliases for Helm commands
- [ ] Add aliases for common CRD resources (Istio, Argo, etc.)
- [ ] Create a Linux/macOS version (bash/zsh)
- [ ] Add tab completion enhancements

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Inspired by [ahmetb/kubectl-aliases](https://github.com/ahmetb/kubectl-aliases)
- The Kubernetes community for making container orchestration ~~painful~~ possible
- Coffee ☕ - the real MVP

---

<p align="center">
  <b>⎈ Happy Kuberneting! ⎈</b><br>
  <i>"There are only two hard problems in computer science:<br>
  cache invalidation, naming things, and off-by-one errors in Kubernetes replica counts."</i>
</p>

---

<p align="center">
  Made with 💙 for the K8s community<br>
  Type <code>kh</code> in your terminal for quick reference
</p>

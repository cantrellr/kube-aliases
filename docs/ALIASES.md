# ⎈ Complete Alias Reference

This document provides a comprehensive reference of all kubectl aliases included in kube-aliases.

---

## Quick Navigation

- [Core Commands](#-core-commands)
- [Get Resources](#-get-resources)
- [Describe Resources](#-describe-resources)
- [Watch Mode](#-watch-mode)
- [Logs & Exec](#-logs--exec)
- [Apply & Delete](#-apply--delete)
- [Output Formats](#-output-formats)
- [Rollout & Scale](#-rollout--scale)
- [Node Operations](#️-node-operations)
- [Context & Namespace](#-context--namespace)
- [CRDs & API](#-crds--api)
- [Metrics & Events](#-metrics--events)
- [PowerShell Functions](#-powershell-functions)

---

## ⚡ Core Commands

| Alias | Full Command | Description |
|-------|--------------|-------------|
| `k` | `kubectl` | Base kubectl command |
| `kg` | `kubectl get` | Get resources |
| `kd` | `kubectl describe` | Describe resources |
| `ke` | `kubectl edit` | Edit resources in default editor |
| `ka` | `kubectl apply` | Apply configuration |
| `kc` | `kubectl create` | Create resources |
| `krm` | `kubectl delete` | Delete resources |
| `kl` | `kubectl logs` | View pod logs |
| `kx` | `kubectl exec` | Execute command in container |

---

## 📦 Get Resources

| Alias | Full Command | Description |
|-------|--------------|-------------|
| `kgp` | `kubectl get pods` | List pods |
| `kgd` | `kubectl get deployments` | List deployments |
| `kgs` | `kubectl get svc` | List services |
| `kgn` | `kubectl get nodes` | List nodes |
| `kgi` | `kubectl get ingress` | List ingresses |
| `kga` | `kubectl get all` | List all resources |
| `kgpa` | `kubectl get pods --all-namespaces` | List pods in all namespaces |
| `kgaa` | `kubectl get all --all-namespaces` | List all resources in all namespaces |
| `kgsec` | `kubectl get secrets` | List secrets |
| `kgcm` | `kubectl get configmaps` | List configmaps |
| `kgc` | `kubectl get crd` | List custom resource definitions |

---

## 🔍 Describe Resources

| Alias | Full Command | Description |
|-------|--------------|-------------|
| `kdp` | `kubectl describe pod` | Describe pod |
| `kdd` | `kubectl describe deployment` | Describe deployment |
| `kds` | `kubectl describe service` | Describe service |
| `kdsec` | `kubectl describe secret` | Describe secret |
| `kdcm` | `kubectl describe configmap` | Describe configmap |

---

## 👀 Watch Mode

| Alias | Full Command | Description |
|-------|--------------|-------------|
| `kgpw` | `kubectl get pods -w` | Watch pods |
| `kgdw` | `kubectl get deployments -w` | Watch deployments |

---

## 📋 Logs & Exec

| Alias | Full Command | Description |
|-------|--------------|-------------|
| `klo` | `kubectl logs -f` | Follow pod logs |
| `kexec` | `kubectl exec -it` | Interactive exec into pod |
| `kpf` | `kubectl port-forward` | Port forward to pod/service |

---

## 📁 Apply & Delete

| Alias | Full Command | Description |
|-------|--------------|-------------|
| `kaf` | `kubectl apply -f` | Apply from file |
| `kdf` | `kubectl delete -f` | Delete from file |

---

## 📄 Output Formats

| Alias | Full Command | Description |
|-------|--------------|-------------|
| `kgy` | `kubectl get -o yaml` | Output as YAML |
| `kgj` | `kubectl get -o json` | Output as JSON |
| `kgw` | `kubectl get -o wide` | Output with extra details |

---

## 🔄 Rollout & Scale

| Alias | Full Command | Description |
|-------|--------------|-------------|
| `krollout` | `kubectl rollout status` | Check rollout status |
| `krestart` | `kubectl rollout restart` | Restart deployment |
| `kscale` | `kubectl scale` | Scale resources |

---

## 🖥️ Node Operations

| Alias | Full Command | Description |
|-------|--------------|-------------|
| `kdrain` | `kubectl drain` | Drain node for maintenance |
| `kunc` | `kubectl uncordon` | Mark node as schedulable |
| `kcord` | `kubectl cordon` | Mark node as unschedulable |

---

## 🎯 Context & Namespace

| Alias | Full Command | Description |
|-------|--------------|-------------|
| `kx` | `kubectx` or `kubectl config use-context` | Switch context |
| `kn` | `kubens` or `kubectl config set-context --namespace` | Switch namespace |

---

## 🧩 CRDs & API

| Alias | Full Command | Description |
|-------|--------------|-------------|
| `kgc` | `kubectl get crd` | List CRDs |
| `kap` | `kubectl api-resources` | List API resources |
| `kav` | `kubectl api-versions` | List API versions |

---

## 📊 Metrics & Events

| Alias | Full Command | Description |
|-------|--------------|-------------|
| `ktop` | `kubectl top pods` | Show pod resource usage |
| `ktopn` | `kubectl top nodes` | Show node resource usage |
| `kev` | `kubectl get events --sort-by=.lastTimestamp` | List events (sorted) |

---

## 🎩 PowerShell Functions

These are available only in PowerShell and provide enhanced functionality:

### `klogs <pod> [container]`

Tail logs from a pod with optional container specification.

```powershell
# Follow logs from a pod
klogs my-pod

# Follow logs from a specific container
klogs my-pod my-container
```

### `kxpod <prefix> [shell]`

Exec into a pod by name prefix (fuzzy matching).

```powershell
# Exec into first pod matching "nginx"
kxpod nginx

# Exec with sh instead of bash
kxpod nginx /bin/sh
```

### `kinfo`

Display current Kubernetes context information.

```powershell
kinfo

# Output:
# Kubernetes Context Info
# =======================
# Context:   my-cluster
# Namespace: default
# Cluster:   https://api.my-cluster.com:6443
```

### `kh`

Display help with all available aliases.

```powershell
kh
```

---

## 💡 Usage Examples

### Get pods with extra info

```powershell
kgpw -n kube-system    # Watch system pods with wide output
```

### Quick debugging workflow

```powershell
kinfo                  # Check current context
kgp                    # List pods
kdp my-pod             # Describe problematic pod
kev                    # Check recent events
klo my-pod             # Follow logs
```

### Deploy and monitor

```powershell
kaf deployment.yaml    # Apply deployment
kgpw                   # Watch pods come up
krollout deployment/my-app  # Check rollout status
```

---

*For more information, see the [README](../README.md) or type `kh` in your terminal.*

#!/bin/bash
# ============================================
# Kubernetes Aliases Installer for Ubuntu Linux
# ============================================
# This script installs kubectl aliases for Bash
#
# Usage: ./install.sh
# ============================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
INSTALL_DIR="${HOME}/.kube-aliases"
ALIAS_FILE="kube-aliases.bash"
BASHRC="${HOME}/.bashrc"
ZSHRC="${HOME}/.zshrc"

echo ""
echo "============================================"
echo " Kubernetes Aliases Installer for Linux"
echo "============================================"
echo ""

# --- Function to install kubectl ---
install_kubectl() {
    echo -e "       ${CYAN}Installing kubectl...${NC}"
    # Download the latest stable kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    # Make it executable
    chmod +x kubectl
    # Move to /usr/local/bin (requires sudo)
    sudo mv kubectl /usr/local/bin/kubectl
    if command -v kubectl &> /dev/null; then
        echo -e "       ${GREEN}✓${NC} kubectl installed successfully"
        return 0
    else
        echo -e "       ${RED}✗${NC} Failed to install kubectl"
        return 1
    fi
}

# --- Function to install kubectx and kubens ---
install_kubectx_kubens() {
    echo -e "       ${CYAN}Installing kubectx and kubens...${NC}"
    
    # Check if git is available
    if ! command -v git &> /dev/null; then
        echo -e "       ${YELLOW}⚠${NC} git is required to install kubectx/kubens"
        echo -e "       Installing git first..."
        sudo apt-get update && sudo apt-get install -y git
    fi
    
    # Clone kubectx repository
    local KUBECTX_DIR="/opt/kubectx"
    if [ -d "$KUBECTX_DIR" ]; then
        echo -e "       ${YELLOW}○${NC} kubectx directory already exists, updating..."
        sudo git -C "$KUBECTX_DIR" pull
    else
        sudo git clone https://github.com/ahmetb/kubectx "$KUBECTX_DIR"
    fi
    
    # Create symlinks
    sudo ln -sf "$KUBECTX_DIR/kubectx" /usr/local/bin/kubectx
    sudo ln -sf "$KUBECTX_DIR/kubens" /usr/local/bin/kubens
    
    # Install bash completion (optional)
    if [ -d /etc/bash_completion.d ]; then
        sudo ln -sf "$KUBECTX_DIR/completion/kubectx.bash" /etc/bash_completion.d/kubectx
        sudo ln -sf "$KUBECTX_DIR/completion/kubens.bash" /etc/bash_completion.d/kubens
    fi
    
    if command -v kubectx &> /dev/null && command -v kubens &> /dev/null; then
        echo -e "       ${GREEN}✓${NC} kubectx and kubens installed successfully"
        return 0
    else
        echo -e "       ${RED}✗${NC} Failed to install kubectx/kubens"
        return 1
    fi
}

# --- Function to prompt user ---
prompt_install() {
    local tool_name="$1"
    local install_func="$2"
    
    echo ""
    read -p "       Would you like to install $tool_name now? [y/N] " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        $install_func
        return $?
    fi
    return 1
}

# --- Check for kubectl ---
echo -e "${CYAN}[1/4]${NC} Checking prerequisites..."
MISSING_KUBECTL=false
MISSING_KUBECTX=false

if command -v kubectl &> /dev/null; then
    echo -e "       ${GREEN}✓${NC} kubectl is installed ($(kubectl version --client --short 2>/dev/null || kubectl version --client 2>/dev/null | head -1))"
else
    echo -e "       ${RED}✗${NC} kubectl not found (REQUIRED)"
    MISSING_KUBECTL=true
fi

# Check for kubectx/kubens (optional but recommended)
if command -v kubectx &> /dev/null; then
    echo -e "       ${GREEN}✓${NC} kubectx is installed"
    HAS_KUBECTX=true
else
    echo -e "       ${YELLOW}○${NC} kubectx not found (optional - enhances kx command)"
    HAS_KUBECTX=false
    MISSING_KUBECTX=true
fi

if command -v kubens &> /dev/null; then
    echo -e "       ${GREEN}✓${NC} kubens is installed"
    HAS_KUBENS=true
else
    echo -e "       ${YELLOW}○${NC} kubens not found (optional - enhances kn command)"
    HAS_KUBENS=false
fi

# Prompt to install missing tools
if [ "$MISSING_KUBECTL" = true ]; then
    echo ""
    echo -e "       ${YELLOW}kubectl is required for the aliases to work.${NC}"
    if prompt_install "kubectl" install_kubectl; then
        MISSING_KUBECTL=false
    else
        echo ""
        echo -e "       ${YELLOW}You can install kubectl manually later:${NC}"
        echo "       https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/"
    fi
fi

if [ "$MISSING_KUBECTX" = true ]; then
    echo ""
    echo -e "       ${YELLOW}kubectx/kubens provide enhanced context and namespace switching.${NC}"
    if prompt_install "kubectx and kubens" install_kubectx_kubens; then
        HAS_KUBECTX=true
        HAS_KUBENS=true
    else
        echo ""
        echo -e "       ${YELLOW}Note: kx and kn will use kubectl fallback commands.${NC}"
    fi
fi
echo ""

# --- Create installation directory ---
echo -e "${CYAN}[2/4]${NC} Creating installation directory..."
if [ ! -d "$INSTALL_DIR" ]; then
    mkdir -p "$INSTALL_DIR"
    echo "       Created: $INSTALL_DIR"
else
    echo "       Directory already exists: $INSTALL_DIR"
fi
echo ""

# --- Create aliases script ---
echo -e "${CYAN}[3/4]${NC} Creating aliases script..."

cat > "${INSTALL_DIR}/${ALIAS_FILE}" << 'ALIASES_EOF'
# --- Kubernetes Bash Aliases ---
# Generated by kube-aliases installer
# https://github.com/cantrellr/kube-aliases

# ============================================
# HELP FUNCTION
# ============================================
kh() {
    cat << 'EOF'
Kubernetes Aliases Help
=======================

CORE
  k        kubectl

VERBS
  kg       kubectl get
  kd       kubectl describe
  ke       kubectl edit
  ka       kubectl apply
  kc       kubectl create
  krm      kubectl delete
  kl       kubectl logs

RESOURCES
  kgp      kubectl get pods
  kgd      kubectl get deployments
  kgs      kubectl get svc
  kgn      kubectl get nodes
  kgi      kubectl get ingress
  kga      kubectl get all
  kgpa     kubectl get pods --all-namespaces
  kgaa     kubectl get all --all-namespaces

WATCH
  kgpw     kubectl get pods -w
  kgdw     kubectl get deployments -w

LOGS / EXEC / PORT-FORWARD
  klo      kubectl logs -f
  kexec    kubectl exec -it
  kpf      kubectl port-forward

DESCRIBE HELPERS
  kdp      kubectl describe pod
  kdd      kubectl describe deployment
  kds      kubectl describe service
  kdsec    kubectl describe secret
  kdcm     kubectl describe configmap

CRDs / API
  kgc      kubectl get crd
  kap      kubectl api-resources
  kav      kubectl api-versions

NODE OPS
  kdrain   kubectl drain
  kunc     kubectl uncordon
  kcord    kubectl cordon

CONTEXT / NAMESPACE
  kx       switch context (kubectx or kubectl config use-context)
  kn       switch namespace (kubens or kubectl config set-context)

METRICS / TOP
  ktop     kubectl top pods
  ktopn    kubectl top nodes

FILE OPERATIONS
  kaf      kubectl apply -f
  kdf      kubectl delete -f

ROLLOUT / SCALE
  krollout kubectl rollout status
  krestart kubectl rollout restart
  kscale   kubectl scale

EVENTS
  kev      kubectl get events --sort-by=.lastTimestamp

OUTPUT FORMATS
  kgy      kubectl get -o yaml
  kgj      kubectl get -o json
  kgw      kubectl get -o wide

SECRETS / CONFIGMAPS
  kgsec    kubectl get secrets
  kgcm     kubectl get configmaps

FUNCTIONS
  klogs    klogs <pod> [container] - tail logs
  kxpod    kxpod <prefix> [shell]  - exec into pod by name prefix
  kinfo    show current context, namespace, and cluster info

HELP
  kh       show this help
EOF
}

# ============================================
# CORE ALIAS
# ============================================
alias k='kubectl'

# ============================================
# VERB SHORTCUTS
# ============================================
alias kg='kubectl get'
alias kd='kubectl describe'
alias ke='kubectl edit'
alias ka='kubectl apply'
alias kc='kubectl create'
alias krm='kubectl delete'
alias kl='kubectl logs'

# ============================================
# RESOURCE SHORTCUTS
# ============================================
alias kgp='kubectl get pods'
alias kgd='kubectl get deployments'
alias kgs='kubectl get svc'
alias kgn='kubectl get nodes'
alias kgi='kubectl get ingress'
alias kga='kubectl get all'
alias kgpa='kubectl get pods --all-namespaces'
alias kgaa='kubectl get all --all-namespaces'

# ============================================
# WATCH
# ============================================
alias kgpw='kubectl get pods -w'
alias kgdw='kubectl get deployments -w'

# ============================================
# LOGS / EXEC / PORT-FORWARD
# ============================================
alias klo='kubectl logs -f'
alias kexec='kubectl exec -it'
alias kpf='kubectl port-forward'

# ============================================
# DESCRIBE HELPERS
# ============================================
alias kdp='kubectl describe pod'
alias kdd='kubectl describe deployment'
alias kds='kubectl describe service'
alias kdsec='kubectl describe secret'
alias kdcm='kubectl describe configmap'

# ============================================
# CRDs / API
# ============================================
alias kgc='kubectl get crd'
alias kap='kubectl api-resources'
alias kav='kubectl api-versions'

# ============================================
# NODE OPS
# ============================================
alias kdrain='kubectl drain'
alias kunc='kubectl uncordon'
alias kcord='kubectl cordon'

# ============================================
# METRICS / TOP
# ============================================
alias ktop='kubectl top pods'
alias ktopn='kubectl top nodes'

# ============================================
# FILE OPERATIONS
# ============================================
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'

# ============================================
# ROLLOUT / SCALE
# ============================================
alias krollout='kubectl rollout status'
alias krestart='kubectl rollout restart'
alias kscale='kubectl scale'

# ============================================
# EVENTS
# ============================================
alias kev='kubectl get events --sort-by=.lastTimestamp'

# ============================================
# OUTPUT FORMATS
# ============================================
alias kgy='kubectl get -o yaml'
alias kgj='kubectl get -o json'
alias kgw='kubectl get -o wide'

# ============================================
# SECRETS / CONFIGMAPS
# ============================================
alias kgsec='kubectl get secrets'
alias kgcm='kubectl get configmaps'

# ============================================
# CONTEXT / NAMESPACE
# ============================================
# Clear any existing kx/kn definitions to avoid conflicts
unset -f kx 2>/dev/null
unset -f kn 2>/dev/null
unalias kx 2>/dev/null
unalias kn 2>/dev/null

if command -v kubectx &> /dev/null; then
    alias kx='kubectx'
else
    kx() {
        if [ -z "$1" ]; then
            kubectl config get-contexts
        else
            kubectl config use-context "$1"
        fi
    }
fi

if command -v kubens &> /dev/null; then
    alias kn='kubens'
else
    kn() {
        if [ -z "$1" ]; then
            kubectl get namespaces
        else
            kubectl config set-context --current --namespace="$1"
        fi
    }
fi

# ============================================
# HELPER FUNCTIONS
# ============================================

# Follow logs for a pod, optionally specifying container
klogs() {
    if [ -z "$1" ]; then
        echo "Usage: klogs <pod-name> [container-name]"
        return 1
    fi
    if [ -n "$2" ]; then
        kubectl logs -f "$1" -c "$2"
    else
        kubectl logs -f "$1"
    fi
}

# Exec into a pod by name prefix
kxpod() {
    if [ -z "$1" ]; then
        echo "Usage: kxpod <pod-name-prefix> [shell]"
        return 1
    fi
    local shell="${2:-/bin/bash}"
    local pod
    pod=$(kubectl get pod -o name | grep "$1" | head -n 1)
    if [ -z "$pod" ]; then
        echo "No pod matching '$1' found."
        return 1
    fi
    local pod_name="${pod#pod/}"
    echo "Connecting to: $pod_name"
    kubectl exec -it "$pod_name" -- "$shell"
}

# Show current context info
kinfo() {
    echo ""
    echo -e "\033[0;36mKubernetes Context Info\033[0m"
    echo -e "\033[0;36m=======================\033[0m"
    
    local context
    context=$(kubectl config current-context 2>/dev/null)
    if [ -n "$context" ]; then
        echo -e "\033[1;33mContext:   \033[0m$context"
    else
        echo -e "\033[1;33mContext:   \033[0;31m(not set)\033[0m"
    fi
    
    local namespace
    namespace=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
    if [ -z "$namespace" ]; then
        namespace="default"
    fi
    echo -e "\033[1;33mNamespace: \033[0m$namespace"
    
    local cluster
    cluster=$(kubectl config view --minify --output 'jsonpath={.clusters[0].cluster.server}' 2>/dev/null)
    if [ -n "$cluster" ]; then
        echo -e "\033[1;33mCluster:   \033[0m$cluster"
    fi
    
    echo ""
}

# ============================================
# KUBECTL COMPLETION (if available)
# ============================================
if command -v kubectl &> /dev/null; then
    # Enable kubectl completion
    if [ -n "$BASH_VERSION" ]; then
        source <(kubectl completion bash)
        # Make completion work with 'k' alias
        complete -o default -F __start_kubectl k
    elif [ -n "$ZSH_VERSION" ]; then
        source <(kubectl completion zsh)
    fi
fi

# ============================================
# STARTUP MESSAGE
# ============================================
echo -e "\033[0;32mKubernetes aliases loaded. Type 'kh' for help.\033[0m"
ALIASES_EOF

echo "       Created: ${INSTALL_DIR}/${ALIAS_FILE}"
echo ""

# --- Update shell profile ---
echo -e "${CYAN}[4/4]${NC} Configuring shell profile..."

SOURCE_LINE="# Kubernetes aliases"
SOURCE_CMD="source \"${INSTALL_DIR}/${ALIAS_FILE}\""

# Function to add source to profile
add_to_profile() {
    local profile_file="$1"
    local profile_name="$2"
    
    if [ -f "$profile_file" ]; then
        if grep -q "kube-aliases" "$profile_file" 2>/dev/null; then
            echo -e "       ${YELLOW}○${NC} ${profile_name} already configured"
        else
            echo "" >> "$profile_file"
            echo "$SOURCE_LINE" >> "$profile_file"
            echo "$SOURCE_CMD" >> "$profile_file"
            echo -e "       ${GREEN}✓${NC} Updated ${profile_name}"
        fi
    else
        echo "$SOURCE_LINE" > "$profile_file"
        echo "$SOURCE_CMD" >> "$profile_file"
        echo -e "       ${GREEN}✓${NC} Created ${profile_name}"
    fi
}

# Add to .bashrc
add_to_profile "$BASHRC" ".bashrc"

# Add to .zshrc if zsh is available
if command -v zsh &> /dev/null; then
    add_to_profile "$ZSHRC" ".zshrc"
fi

echo ""
echo "============================================"
echo -e " ${GREEN}Installation Complete!${NC}"
echo "============================================"
echo ""
echo " To start using the aliases now, run:"
echo ""
echo -e "   ${CYAN}source ${INSTALL_DIR}/${ALIAS_FILE}${NC}"
echo ""
echo " Or simply open a new terminal."
echo ""
echo " Type ${CYAN}kh${NC} for a list of all available aliases."
echo ""
echo "============================================"

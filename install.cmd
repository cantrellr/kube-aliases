@echo off
REM ============================================
REM Kubernetes Aliases Installer for Windows
REM ============================================
REM This script installs kubectl aliases for both
REM PowerShell and Command Prompt (CMD)
REM
REM Run as Administrator for best results
REM ============================================

setlocal enabledelayedexpansion

echo.
echo ============================================
echo  Kubernetes Aliases Installer for Windows
echo ============================================
echo.

REM --- Configuration ---
set "INSTALL_DIR=D:\DevTools\kube-aliases"
set "PS_PROFILE_SCRIPT=kube-profile.ps1"
set "CMD_ALIAS_SCRIPT=kube-aliases.cmd"

REM --- Check for Admin (optional but recommended) ---
net session >nul 2>&1
if %errorLevel% == 0 (
    echo [INFO] Running with Administrator privileges
) else (
    echo [WARN] Not running as Administrator. Some features may not work.
    echo [WARN] Consider right-clicking and "Run as Administrator"
)
echo.

REM --- Step 1: Create installation directory ---
echo [1/5] Creating installation directory...
if not exist "%INSTALL_DIR%" (
    mkdir "%INSTALL_DIR%"
    if %errorLevel% neq 0 (
        echo [ERROR] Failed to create directory: %INSTALL_DIR%
        echo [ERROR] Please check permissions or run as Administrator
        goto :error
    )
    echo       Created: %INSTALL_DIR%
) else (
    echo       Directory already exists: %INSTALL_DIR%
)
echo.

REM --- Step 2: Create PowerShell profile script ---
echo [2/5] Creating PowerShell aliases script...
(
echo # --- Kubernetes PowerShell Profile ---
echo # Location: %INSTALL_DIR%\%PS_PROFILE_SCRIPT%
echo # Generated: %date% %time%
echo.
echo # ============================================
echo # HELP FUNCTION
echo # ============================================
echo function kh {
echo     $help = @"
echo Kubernetes Aliases Help
echo =======================
echo.
echo CORE
echo   k        kubectl
echo.
echo VERBS
echo   kg       kubectl get
echo   kd       kubectl describe
echo   ke       kubectl edit
echo   ka       kubectl apply
echo   kc       kubectl create
echo   krm      kubectl delete
echo   kl       kubectl logs
echo   kx       kubectl exec
echo.
echo RESOURCES
echo   kgp      kubectl get pods
echo   kgd      kubectl get deployments
echo   kgs      kubectl get svc
echo   kgn      kubectl get nodes
echo   kgi      kubectl get ingress
echo   kga      kubectl get all
echo   kgpa     kubectl get pods --all-namespaces
echo   kgaa     kubectl get all --all-namespaces
echo.
echo WATCH
echo   kgpw     kubectl get pods -w
echo   kgdw     kubectl get deployments -w
echo.
echo LOGS / EXEC / PORT-FORWARD
echo   klo      kubectl logs -f
echo   kexec    kubectl exec -it
echo   kpf      kubectl port-forward
echo.
echo DESCRIBE HELPERS
echo   kdp      kubectl describe pod
echo   kdd      kubectl describe deployment
echo   kds      kubectl describe service
echo   kdsec    kubectl describe secret
echo   kdcm     kubectl describe configmap
echo.
echo CRDs / API
echo   kgc      kubectl get crd
echo   kap      kubectl api-resources
echo   kav      kubectl api-versions
echo.
echo NODE OPS
echo   kdrain   kubectl drain
echo   kunc     kubectl uncordon
echo   kcord    kubectl cordon
echo.
echo CONTEXT / NAMESPACE
echo   kx     switch context ^(kubectx or kubectl config use-context^)
echo   kn      switch namespace ^(kubens or kubectl config set-context^)
echo.
echo METRICS / TOP
echo   ktop     kubectl top pods
echo   ktopn    kubectl top nodes
echo.
echo FILE OPERATIONS
echo   kaf      kubectl apply -f
echo   kdf      kubectl delete -f
echo.
echo ROLLOUT / SCALE
echo   krollout kubectl rollout status
echo   krestart kubectl rollout restart
echo   kscale   kubectl scale
echo.
echo EVENTS
echo   kev      kubectl get events --sort-by=.lastTimestamp
echo.
echo OUTPUT FORMATS
echo   kgy      kubectl get -o yaml
echo   kgj      kubectl get -o json
echo   kgw      kubectl get -o wide
echo.
echo SECRETS / CONFIGMAPS
echo   kgsec    kubectl get secrets
echo   kgcm     kubectl get configmaps
echo.
echo FUNCTIONS ^(PowerShell only^)
echo   klogs    klogs ^<pod^> [container] - tail logs
echo   kxpod    kxpod ^<prefix^> [shell]  - exec into pod by name prefix
echo   kinfo    show current context, namespace, and cluster info
echo.
echo HELP
echo   kh       show this help
echo "@
echo     Write-Host $help
echo }
echo.
echo # ============================================
echo # CORE ALIAS
echo # ============================================
echo Set-Alias k kubectl
echo.
echo # ============================================
echo # VERB SHORTCUTS ^(as functions for arguments^)
echo # ============================================
echo function kg { kubectl get $args }
echo function kd { kubectl describe $args }
echo function ke { kubectl edit $args }
echo function ka { kubectl apply $args }
echo function kc { kubectl create $args }
echo function krm { kubectl delete $args }
echo function kl { kubectl logs $args }
echo function kx { kubectl exec $args }
echo.
echo # ============================================
echo # RESOURCE SHORTCUTS
echo # ============================================
echo function kgp { kubectl get pods $args }
echo function kgd { kubectl get deployments $args }
echo function kgs { kubectl get svc $args }
echo function kgn { kubectl get nodes $args }
echo function kgi { kubectl get ingress $args }
echo function kga { kubectl get all $args }
echo function kgpa { kubectl get pods --all-namespaces $args }
echo function kgaa { kubectl get all --all-namespaces $args }
echo.
echo # ============================================
echo # WATCH
echo # ============================================
echo function kgpw { kubectl get pods -w $args }
echo function kgdw { kubectl get deployments -w $args }
echo.
echo # ============================================
echo # LOGS / EXEC / PORT-FORWARD
echo # ============================================
echo function klo { kubectl logs -f $args }
echo function kexec { kubectl exec -it $args }
echo function kpf { kubectl port-forward $args }
echo.
echo # ============================================
echo # DESCRIBE HELPERS
echo # ============================================
echo function kdp { kubectl describe pod $args }
echo function kdd { kubectl describe deployment $args }
echo function kds { kubectl describe service $args }
echo function kdsec { kubectl describe secret $args }
echo function kdcm { kubectl describe configmap $args }
echo.
echo # ============================================
echo # CRDs / API
echo # ============================================
echo function kgc { kubectl get crd $args }
echo function kap { kubectl api-resources $args }
echo function kav { kubectl api-versions $args }
echo.
echo # ============================================
echo # NODE OPS
echo # ============================================
echo function kdrain { kubectl drain $args }
echo function kunc { kubectl uncordon $args }
echo function kcord { kubectl cordon $args }
echo.
echo # ============================================
echo # METRICS / TOP
echo # ============================================
echo function ktop { kubectl top pods $args }
echo function ktopn { kubectl top nodes $args }
echo.
echo # ============================================
echo # FILE OPERATIONS
echo # ============================================
echo function kaf { kubectl apply -f $args }
echo function kdf { kubectl delete -f $args }
echo.
echo # ============================================
echo # ROLLOUT / SCALE
echo # ============================================
echo function krollout { kubectl rollout status $args }
echo function krestart { kubectl rollout restart $args }
echo function kscale { kubectl scale $args }
echo.
echo # ============================================
echo # EVENTS
echo # ============================================
echo function kev { kubectl get events --sort-by=.lastTimestamp $args }
echo.
echo # ============================================
echo # OUTPUT FORMATS
echo # ============================================
echo function kgy { kubectl get -o yaml $args }
echo function kgj { kubectl get -o json $args }
echo function kgw { kubectl get -o wide $args }
echo.
echo # ============================================
echo # SECRETS / CONFIGMAPS
echo # ============================================
echo function kgsec { kubectl get secrets $args }
echo function kgcm { kubectl get configmaps $args }
echo.
echo # ============================================
echo # CONTEXT / NAMESPACE
echo # ============================================
echo if ^(Get-Command kubectx -ErrorAction SilentlyContinue^) {
echo     Set-Alias kx kubectx
echo } else {
echo     function kx { kubectl config use-context $args }
echo }
echo.
echo if ^(Get-Command kubens -ErrorAction SilentlyContinue^) {
echo     Set-Alias kn kubens
echo } else {
echo     function kn {
echo         param^(
echo             [Parameter^(Mandatory=$true^)]
echo             [string] $Namespace
echo         ^)
echo         kubectl config set-context --current --namespace=$Namespace
echo     }
echo }
echo.
echo # ============================================
echo # HELPER FUNCTIONS
echo # ============================================
echo function klogs {
echo     param^(
echo         [Parameter^(Mandatory=$true^)]
echo         [string] $PodName,
echo         [string] $Container
echo     ^)
echo     if ^($Container^) {
echo         kubectl logs -f $PodName -c $Container
echo     } else {
echo         kubectl logs -f $PodName
echo     }
echo }
echo.
echo function kxpod {
echo     param^(
echo         [Parameter^(Mandatory=$true^)]
echo         [string] $NamePrefix,
echo         [string] $Shell = "/bin/bash"
echo     ^)
echo     $pod = kubectl get pod -o name ^| Select-String $NamePrefix ^| Select-Object -First 1
echo     if ^(-not $pod^) {
echo         Write-Host "No pod matching '$NamePrefix' found." -ForegroundColor Yellow
echo         return
echo     }
echo     $podName = $pod.ToString^(^).Replace^("pod/",""^)
echo     kubectl exec -it $podName -- $Shell
echo }
echo.
echo function kinfo {
echo     Write-Host "`nKubernetes Context Info" -ForegroundColor Cyan
echo     Write-Host "=======================" -ForegroundColor Cyan
echo.    
echo     $context = kubectl config current-context 2^>$null
echo     if ^($context^) {
echo         Write-Host "Context:   " -NoNewline -ForegroundColor Yellow
echo         Write-Host $context
echo     } else {
echo         Write-Host "Context:   " -NoNewline -ForegroundColor Yellow
echo         Write-Host "^(not set^)" -ForegroundColor Red
echo     }
echo.    
echo     $namespace = kubectl config view --minify --output 'jsonpath={..namespace}' 2^>$null
echo     if ^(-not $namespace^) { $namespace = "default" }
echo     Write-Host "Namespace: " -NoNewline -ForegroundColor Yellow
echo     Write-Host $namespace
echo.    
echo     $cluster = kubectl config view --minify --output 'jsonpath={.clusters[0].cluster.server}' 2^>$null
echo     if ^($cluster^) {
echo         Write-Host "Cluster:   " -NoNewline -ForegroundColor Yellow
echo         Write-Host $cluster
echo     }
echo.    
echo     Write-Host ""
echo }
echo.
echo # ============================================
echo # STARTUP MESSAGE
echo # ============================================
echo Write-Host "Kubernetes aliases loaded. Type 'kh' for help." -ForegroundColor Green
) > "%INSTALL_DIR%\%PS_PROFILE_SCRIPT%"

if %errorLevel% neq 0 (
    echo [ERROR] Failed to create PowerShell script
    goto :error
)
echo       Created: %INSTALL_DIR%\%PS_PROFILE_SCRIPT%
echo.

REM --- Step 3: Create CMD alias script ---
echo [3/5] Creating CMD aliases script...
(
echo @echo off
echo REM --- Kubernetes DOSKEY Aliases for CMD ---
echo REM Location: %INSTALL_DIR%\%CMD_ALIAS_SCRIPT%
echo REM Generated: %date% %time%
echo.
echo REM ============================================
echo REM HELP COMMAND
echo REM ============================================
echo doskey kh=echo. ^^^& echo Kubernetes Aliases Help ^^^& echo ======================= ^^^& echo. ^^^& echo CORE ^^^& echo   k        kubectl ^^^& echo. ^^^& echo VERBS ^^^& echo   kg       kubectl get ^^^& echo   kd       kubectl describe ^^^& echo   ke       kubectl edit ^^^& echo   ka       kubectl apply ^^^& echo   kc       kubectl create ^^^& echo   krm      kubectl delete ^^^& echo   kl       kubectl logs ^^^& echo   kx       kubectl exec ^^^& echo. ^^^& echo RESOURCES ^^^& echo   kgp      kubectl get pods ^^^& echo   kgd      kubectl get deployments ^^^& echo   kgs      kubectl get svc ^^^& echo   kgn      kubectl get nodes ^^^& echo   kgi      kubectl get ingress ^^^& echo   kga      kubectl get all ^^^& echo   kgpa     kubectl get pods --all-namespaces ^^^& echo   kgaa     kubectl get all --all-namespaces ^^^& echo. ^^^& echo WATCH ^^^& echo   kgpw     kubectl get pods -w ^^^& echo   kgdw     kubectl get deployments -w ^^^& echo. ^^^& echo LOGS / EXEC / PORT-FORWARD ^^^& echo   klo      kubectl logs -f ^^^& echo   kexec    kubectl exec -it ^^^& echo   kpf      kubectl port-forward ^^^& echo. ^^^& echo DESCRIBE HELPERS ^^^& echo   kdp      kubectl describe pod ^^^& echo   kdd      kubectl describe deployment ^^^& echo   kds      kubectl describe service ^^^& echo   kdsec    kubectl describe secret ^^^& echo   kdcm     kubectl describe configmap ^^^& echo. ^^^& echo CRDs / API ^^^& echo   kgc      kubectl get crd ^^^& echo   kap      kubectl api-resources ^^^& echo   kav      kubectl api-versions ^^^& echo. ^^^& echo NODE OPS ^^^& echo   kdrain   kubectl drain ^^^& echo   kunc     kubectl uncordon ^^^& echo   kcord    kubectl cordon ^^^& echo. ^^^& echo CONTEXT / NAMESPACE ^^^& echo   kx     kubectx ^(switch context^) ^^^& echo   kn      kubens ^(switch namespace^) ^^^& echo. ^^^& echo METRICS / TOP ^^^& echo   ktop     kubectl top pods ^^^& echo   ktopn    kubectl top nodes ^^^& echo. ^^^& echo FILE OPERATIONS ^^^& echo   kaf      kubectl apply -f ^^^& echo   kdf      kubectl delete -f ^^^& echo. ^^^& echo ROLLOUT / SCALE ^^^& echo   krollout kubectl rollout status ^^^& echo   krestart kubectl rollout restart ^^^& echo   kscale   kubectl scale ^^^& echo. ^^^& echo EVENTS ^^^& echo   kev      kubectl get events --sort-by=.lastTimestamp ^^^& echo. ^^^& echo OUTPUT FORMATS ^^^& echo   kgy      kubectl get -o yaml ^^^& echo   kgj      kubectl get -o json ^^^& echo   kgw      kubectl get -o wide ^^^& echo. ^^^& echo SECRETS / CONFIGMAPS ^^^& echo   kgsec    kubectl get secrets ^^^& echo   kgcm     kubectl get configmaps ^^^& echo. ^^^& echo HELP ^^^& echo   kh       show this help ^^^& echo.
echo.
echo REM ============================================
echo REM CORE
echo REM ============================================
echo doskey k=kubectl.exe $*
echo.
echo REM ============================================
echo REM VERBS
echo REM ============================================
echo doskey kg=kubectl.exe get $*
echo doskey kd=kubectl.exe describe $*
echo doskey ke=kubectl.exe edit $*
echo doskey ka=kubectl.exe apply $*
echo doskey kc=kubectl.exe create $*
echo doskey krm=kubectl.exe delete $*
echo doskey kl=kubectl.exe logs $*
echo doskey kx=kubectl.exe exec $*
echo.
echo REM ============================================
echo REM RESOURCES
echo REM ============================================
echo doskey kgp=kubectl.exe get pods $*
echo doskey kgd=kubectl.exe get deployments $*
echo doskey kgs=kubectl.exe get svc $*
echo doskey kgn=kubectl.exe get nodes $*
echo doskey kgi=kubectl.exe get ingress $*
echo doskey kga=kubectl.exe get all $*
echo doskey kgpa=kubectl.exe get pods --all-namespaces $*
echo doskey kgaa=kubectl.exe get all --all-namespaces $*
echo.
echo REM ============================================
echo REM WATCH
echo REM ============================================
echo doskey kgpw=kubectl.exe get pods -w $*
echo doskey kgdw=kubectl.exe get deployments -w $*
echo.
echo REM ============================================
echo REM LOGS / EXEC / PORT-FORWARD
echo REM ============================================
echo doskey klo=kubectl.exe logs -f $*
echo doskey kexec=kubectl.exe exec -it $*
echo doskey kpf=kubectl.exe port-forward $*
echo.
echo REM ============================================
echo REM DESCRIBE HELPERS
echo REM ============================================
echo doskey kdp=kubectl.exe describe pod $*
echo doskey kdd=kubectl.exe describe deployment $*
echo doskey kds=kubectl.exe describe service $*
echo doskey kdsec=kubectl.exe describe secret $*
echo doskey kdcm=kubectl.exe describe configmap $*
echo.
echo REM ============================================
echo REM CRDs / API
echo REM ============================================
echo doskey kgc=kubectl.exe get crd $*
echo doskey kap=kubectl.exe api-resources $*
echo doskey kav=kubectl.exe api-versions $*
echo.
echo REM ============================================
echo REM NODE OPS
echo REM ============================================
echo doskey kdrain=kubectl.exe drain $*
echo doskey kunc=kubectl.exe uncordon $*
echo doskey kcord=kubectl.exe cordon $*
echo.
echo REM ============================================
echo REM METRICS / TOP
echo REM ============================================
echo doskey ktop=kubectl.exe top pods $*
echo doskey ktopn=kubectl.exe top nodes $*
echo.
echo REM ============================================
echo REM FILE OPERATIONS
echo REM ============================================
echo doskey kaf=kubectl.exe apply -f $*
echo doskey kdf=kubectl.exe delete -f $*
echo.
echo REM ============================================
echo REM ROLLOUT / SCALE
echo REM ============================================
echo doskey krollout=kubectl.exe rollout status $*
echo doskey krestart=kubectl.exe rollout restart $*
echo doskey kscale=kubectl.exe scale $*
echo.
echo REM ============================================
echo REM EVENTS
echo REM ============================================
echo doskey kev=kubectl.exe get events --sort-by=.lastTimestamp $*
echo.
echo REM ============================================
echo REM OUTPUT FORMATS
echo REM ============================================
echo doskey kgy=kubectl.exe get -o yaml $*
echo doskey kgj=kubectl.exe get -o json $*
echo doskey kgw=kubectl.exe get -o wide $*
echo.
echo REM ============================================
echo REM SECRETS / CONFIGMAPS
echo REM ============================================
echo doskey kgsec=kubectl.exe get secrets $*
echo doskey kgcm=kubectl.exe get configmaps $*
echo.
echo REM ============================================
echo REM CONTEXT / NAMESPACE
echo REM ============================================
echo doskey kx=kubectx.exe $*
echo doskey kn=kubens.exe $*
echo.
echo REM Fallbacks ^(uncomment if you don't have kubectx/kubens^)
echo REM doskey kx=kubectl.exe config use-context $*
echo REM doskey kn=kubectl.exe config set-context --current --namespace=$*
echo.
echo REM ============================================
echo REM INFO
echo REM ============================================
echo doskey kinfo=echo. ^^^& echo Kubernetes Context Info ^^^& echo ======================= ^^^& kubectl.exe config current-context ^^^& kubectl.exe config view --minify --output jsonpath="{.contexts[0].context.namespace}" ^^^& echo. ^^^& kubectl.exe config view --minify --output jsonpath="{.clusters[0].cluster.server}" ^^^& echo.
) > "%INSTALL_DIR%\%CMD_ALIAS_SCRIPT%"

if %errorLevel% neq 0 (
    echo [ERROR] Failed to create CMD script
    goto :error
)
echo       Created: %INSTALL_DIR%\%CMD_ALIAS_SCRIPT%
echo.

REM --- Step 4: Configure PowerShell profile ---
echo [4/5] Configuring PowerShell profile...

REM Get PowerShell profile path and update it
powershell -NoProfile -Command "$profilePath = $PROFILE; $loadLine = '. \""%INSTALL_DIR%\%PS_PROFILE_SCRIPT%\"\"'; if (-not (Test-Path $profilePath)) { New-Item -ItemType File -Path $profilePath -Force | Out-Null; Write-Host '       Created new profile: ' -NoNewline; Write-Host $profilePath }; $content = Get-Content $profilePath -Raw -ErrorAction SilentlyContinue; if ($content -and $content.Contains('kube-profile.ps1')) { Write-Host '       Profile already contains kube-aliases reference' } else { Add-Content -Path $profilePath -Value \"`n# Load Kubernetes aliases`n$loadLine\"; Write-Host '       Updated profile: ' -NoNewline; Write-Host $profilePath }"

echo.

REM --- Step 5: Configure CMD AutoRun registry ---
echo [5/5] Configuring CMD AutoRun registry...

REM Check if AutoRun already exists
reg query "HKCU\Software\Microsoft\Command Processor" /v AutoRun >nul 2>&1
if %errorLevel% == 0 (
    REM AutoRun exists, check if it already has our script
    for /f "tokens=2*" %%a in ('reg query "HKCU\Software\Microsoft\Command Processor" /v AutoRun 2^>nul ^| find "AutoRun"') do set "CURRENT_AUTORUN=%%b"
    
    echo !CURRENT_AUTORUN! | find /i "kube-aliases.cmd" >nul 2>&1
    if %errorLevel% == 0 (
        echo       AutoRun already configured for kube-aliases
    ) else (
        REM Append to existing AutoRun
        reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d "!CURRENT_AUTORUN! & \"%INSTALL_DIR%\%CMD_ALIAS_SCRIPT%\"" /f >nul 2>&1
        echo       Appended to existing AutoRun registry
    )
) else (
    REM AutoRun doesn't exist, create it
    reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d "\"%INSTALL_DIR%\%CMD_ALIAS_SCRIPT%\"" /f >nul 2>&1
    echo       Created AutoRun registry entry
)

echo.
echo ============================================
echo  Installation Complete!
echo ============================================
echo.
echo Files installed:
echo   - %INSTALL_DIR%\%PS_PROFILE_SCRIPT%
echo   - %INSTALL_DIR%\%CMD_ALIAS_SCRIPT%
echo.
echo Configuration:
echo   - PowerShell profile updated
echo   - CMD AutoRun registry configured
echo.
echo Next steps:
echo   1. Open a NEW PowerShell or CMD window
echo   2. Type 'kh' to see all available aliases
echo   3. Type 'k version' to verify kubectl works
echo.
echo Tip: If kubectl is not installed, get it from:
echo   https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/
echo.
echo ============================================
goto :end

:error
echo.
echo ============================================
echo  Installation Failed!
echo ============================================
echo.
echo Please check the error messages above and try again.
echo You may need to run this script as Administrator.
echo.
pause
exit /b 1

:end
pause
exit /b 0

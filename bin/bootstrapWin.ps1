# -= SET UP WSL AND UBUNTU =-

# Check if WSL is enabled
$wslFeature = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
$vmPlatformFeature = Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform

if ($wslFeature.State -ne 'Enabled' -or $vmPlatformFeature.State -ne 'Enabled') {
    Write-Output "Enabling WSL and VirtualMachinePlatform features..."

    # Enable the required Windows features for WSL and install WSL2
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

    # Set WSL2 as the default version
    wsl --set-default-version 2

    # Restart the computer to apply changes
    Write-Output "Restarting the computer to apply changes..."
    Restart-Computer
}

# Wait for the computer to restart (requires manual continuation after restart)
Read-Host "Press Enter to continue after restart..."

$distributionName = "Ubuntu"
if (!(wsl --list | Where-Object { $_ -match $distributionName })) {
    # Distribution is not installed, install it
    wsl --install -d $distributionName
    # Set WSL to use Ubuntu as the default distro
    wsl --set-default Ubuntu
} else {
    # Distribution is already installed, do something else
    Write-Host "Distribution $distributionName is already installed"
}

wsl --shutdown



# -= SET UP GIT NATIVE TO WINDOWS =-

# Install Git using winget
winget install --id Git.Git -e --source winget

# Add Git to the PATH
$gitInstallDir = "C:\Program Files\Git\bin"
$env:PATH += ";$gitInstallDir"
[Environment]::SetEnvironmentVariable("PATH", $env:PATH, "User")

# Verify Git installation
echo ""
echo "Git installed at version:"
git --version

# Optionally, set up Git configuration (replace with your details)
git config --global user.name "Johan Weitner"
git config --global user.email "johanweitner@gmail.com"

# Get Ansible playbook and initialize a playbook run
$url = "https://raw.githubusercontent.com/johan-weitner/ansible-dotfiles/main/bin/dotfiles"
$scriptPath = "C:\temp\dotfiles"

try {
    Invoke-WebRequest -Uri $url -OutFile $scriptPath
    Write-Host "File downloaded successfully!"
    # Invoke WSL to execute the shell script
    wsl bash -c "bash $scriptPath"
} catch {
    Write-Error "Error downloading file: $_"
}

echo ""
echo "***** Windows setup done *****"
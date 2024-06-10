# Part 1: Enable WSL and Schedule Part 2

# Define the path for Part 2 script
$part2ScriptPath = "$env:TEMP\Part2.ps1"

# Write Part 2 script content to a file
$part2ScriptContent = @'
# Part 2: Continue setup after reboot

# Install Ubuntu from the Microsoft Store if not already installed
$installedDistros = wsl --list --online
if ($installedDistros -notcontains "Ubuntu") {
    Write-Output "Installing Ubuntu..."
    wsl --install -d Ubuntu
}

# Set WSL to use Ubuntu as the default distro
wsl --set-default Ubuntu

# Download and install Git for Windows
$gitInstallerPath = "$env:TEMP\Git-2.33.1.2-64-bit.exe"
if (-not (Test-Path $gitInstallerPath)) {
    Write-Output "Downloading and installing Git for Windows..."
    Invoke-WebRequest -Uri "https://github.com/git-for-windows/git/releases/download/v2.33.1.windows.2/Git-2.33.1.2-64-bit.exe" -OutFile $gitInstallerPath
    Start-Process -FilePath $gitInstallerPath -ArgumentList "/SILENT" -Wait
}

# Optionally, set up Git configuration (replace with your details)
git config --global user.name "Your Name"
git config --global user.email "youremail@example.com"

# Install Chocolatey (a package manager for Windows)
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Output "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

# Use Chocolatey to install Ansible
if (-not (Get-Command ansible -ErrorAction SilentlyContinue)) {
    Write-Output "Installing Ansible using Chocolatey..."
    choco install ansible -y
}

# Create a script to install Git and Ansible on Ubuntu
$installScript = @"
#!/bin/bash

# Update package list and install dependencies
sudo apt-get update
sudo apt-get install -y software-properties-common

# Install Git
sudo apt-get install -y git

# Install Ansible
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install -y ansible

# Optionally, configure Git (replace with your details)
git config --global user.name "Your Name"
git config --global user.email "youremail@example.com"

# Clean up
sudo apt-get clean
"@

# Write the script to a file
$installScriptPath = "$env:TEMP\install-ubuntu.sh"
Set-Content -Path $installScriptPath -Value $installScript

# Make the script executable and run it in WSL
wsl chmod +x /mnt/c/Users/$(whoami)/AppData/Local/Temp/install-ubuntu.sh
wsl /mnt/c/Users/$(whoami)/AppData/Local/Temp/install-ubuntu.sh

# Clean up the scheduled task
schtasks /delete /tn "CompleteSetup" /f
'@

Set-Content -Path $part2ScriptPath -Value $part2ScriptContent

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

    # Schedule Part 2 to run after reboot
    Write-Output "Scheduling Part 2 to run after reboot..."
    schtasks /create /tn "CompleteSetup" /tr "powershell.exe -File $part2ScriptPath" /sc onstart /ru "$env:USERNAME"

    # Restart the computer to apply changes
    Write-Output "Restarting the computer to apply changes..."
    Restart-Computer
} else {
    Write-Output "WSL and VirtualMachinePlatform features are already enabled. Running Part 2..."

    # Run Part 2 immediately if no restart is needed
    . $part2ScriptPath
}
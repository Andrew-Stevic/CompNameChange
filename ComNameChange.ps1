# This script is intended to to rename computers to match their serial number
# In addition to checking if the computer has already been renamed, the script will disable fast boot (which prevents the rename from occurring when the PC is rebooted)
# This script is not configured to force a reboot, however that is possible if required in your environment
# Because reboot is not enabled, this script produces a pop up with a configurable message requesting the end user reboot

# Get the serial number of the computer
$serialNumber = Get-WmiObject -Class Win32_BIOS | Select-Object -ExpandProperty SerialNumber

# Get the current computer name
$currentName = $env:COMPUTERNAME

# Check if the computer name already matches the serial number
if ($currentName -eq $serialNumber) {
    # Computer name already matches, no action needed
    Write-Host "Name matches, no action required"
}
else {
    # If the name does not match, rename it
    Rename-Computer -NewName $serialNumber -Force
    Write-Host "Computer renamed to $serialNumber."
}

# Disable Fast Boot with reg key modification
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
$keyName = "HiberbootEnabled"

if (Test-Path $resgistryPath) {
    Set-ItemProperty -Path $registryPath -Name $keyName -Value 0
    Write-Host "Fast Boot disabled successfully."
}
else {
    Write-Host "Registry Key not found!"
}

# Display Reboot Message
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show("This Message is from IT Support. Changes have been made to your computer, reboot your PC at your earliest convenience. Please contact the help desk with any questions.", "Reboot Required", [System.Windows.Forms.MessageBoxButton]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)

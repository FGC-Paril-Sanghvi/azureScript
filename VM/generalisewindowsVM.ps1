# ---------------------------------------------------------
# This script will:
# 1. Delete the C:\Windows\Panther directory
# 2. Enable the CD/DVD-ROM by updating the registry
# 3. Run Sysprep with /generalize /shutdown
#
# IMPORTANT: Run as Administrator
# ---------------------------------------------------------

Write-Host "`n[1] Deleting C:\Windows\Panther..."
if (Test-Path -Path "C:\Windows\Panther") {
    Remove-Item -Path "C:\Windows\Panther" -Recurse -Force
    if (Test-Path -Path "C:\Windows\Panther") {
        Write-Host "Failed to delete C:\Windows\Panther. Please ensure you are running PowerShell as Administrator."
        return
    }
    Write-Host "Deleted C:\Windows\Panther."
} else {
    Write-Host "C:\Windows\Panther not found. Skipping."
}
Write-Host

Write-Host "[2] Enabling CD/DVD-ROM in the registry..."
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\cdrom" -Name "start" -PropertyType DWord -Value 1 -Force | Out-Null
Write-Host "CD/DVD-ROM enabled."
Write-Host

# NOTE: If you have group policies restricting removable storage,
# you may need to adjust them before sysprep. Example:
# Computer Configuration > Administrative Templates > System > Removable Storage Access
# All Removable Storage classes: Deny All Access = Disabled (or Not Configured)

Write-Host "[3] Running Sysprep..."
Set-Location "$env:WINDIR\system32\sysprep"
Start-Process -FilePath ".\sysprep.exe" -ArgumentList "/generalize /shutdown" 
#-Wait
#Write-Host "Sysprep initiated. The system will shut down once Sysprep completes."

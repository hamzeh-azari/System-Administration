# Check if the script is running with admin rights
$runAsAdmin = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
$adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

if (-not $runAsAdmin.IsInRole($adminRole)) {
    # If the script is not running as admin, it will prompt to re-run as admin
    $argList = "-NoProfile -ExecutionPolicy Bypass -File $($myinvocation.MyCommand.Definition)"
    Start-Process powershell.exe -Verb runAs -ArgumentList $argList
    exit
}

# Extract system model (device)
$computerModel = Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty Model

# Extract CPU type and model
$cpuInfo = Get-WmiObject -Class Win32_Processor | Select-Object -ExpandProperty Name

# Extract operating system installation date
$installDate = Get-WmiObject -Class Win32_OperatingSystem | Select-Object -ExpandProperty InstallDate

# Extract device serial number
$serialNumber = Get-WmiObject -Class Win32_BIOS | Select-Object -ExpandProperty SerialNumber

# Try to extract BIOS version instead of Release Date (since ReleaseDate might not exist)
$biosVersion = Get-WmiObject -Class Win32_BIOS | Select-Object -ExpandProperty BIOSVersion

# Display extracted information
Write-Output "Device Model: $computerModel"
Write-Output "CPU Model: $cpuInfo"
Write-Output "Operating System Install Date: $installDate"
Write-Output "Device Serial Number: $serialNumber"
Write-Output "BIOS Version: $biosVersion"

# If BIOS Release Date exists, calculate device age, else skip it
$biosDate = Get-WmiObject -Class Win32_BIOS | Select-Object -ExpandProperty ReleasedDate

if ($biosDate) {
    try {
        # Attempt to calculate the device age based on BIOS release date
        $deviceAge = ((Get-Date) - [Management.ManagementDateTimeConverter]::ToDateTime($biosDate)).Days
        Write-Output "Approximate Device Age (based on BIOS release date): $($deviceAge / 365) years"
    } catch {
        Write-Output "Unable to calculate device age based on BIOS release date."
    }
} else {
    Write-Output "BIOS release date not available. Cannot calculate device age."
}

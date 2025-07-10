# Device Hardware Info Extractor (PowerShell)

A PowerShell script that extracts detailed hardware and system information from the local computer, including **device model**, **CPU type**, **BIOS version**, **serial number**, **Windows install date**, and optionally calculates the **approximate device age**.

---

## 🧰 Features

- Automatically **re-launches with admin privileges** if not already elevated
- Retrieves:
  - Device model
  - CPU model
  - Serial number
  - BIOS version
  - Windows OS install date
  - BIOS release date (if available)
- Calculates device age in years based on BIOS release date

---

## 📦 Requirements

- PowerShell (Windows)
- Local execution privileges
- Admin rights (script enforces elevation)

---

## 🚀 Usage

1. Save the script as `Get-Device-Info.ps1`

2. Run it (double-click or PowerShell):
   ```powershell
   .\Get-Device-Info.ps1
   ```
3. The script will auto-prompt for admin access if not already elevated.
4. Output will display directly in the PowerShell console.

---

## 🧾 Sample Script
```powershell

<#
.SYNOPSIS
    Extracts system hardware information and calculates approximate device age.

.DESCRIPTION
    This script collects hardware info including the device model, CPU, BIOS version, 
    serial number, and Windows installation date. If the BIOS release date is available, 
    it estimates the device's age. The script ensures it is run with administrator rights.

.NOTES
    Author: Hamzeh Azari Hashjin
    Date: 2025-07-09
    Version: 1.0
    Requires: PowerShell (Run as Administrator)
#>

# Check if the script is running with admin rights
$runAsAdmin = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
$adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

if (-not $runAsAdmin.IsInRole($adminRole)) {
    # Relaunch script as admin
    $argList = "-NoProfile -ExecutionPolicy Bypass -File $($myinvocation.MyCommand.Definition)"
    Start-Process powershell.exe -Verb runAs -ArgumentList $argList
    exit
}

# Extract system model (device)
$computerModel = Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty Model

# Extract CPU type and model
$cpuInfo = Get-WmiObject -Class Win32_Processor | Select-Object -ExpandProperty Name

# Extract OS install date
$installDate = Get-WmiObject -Class Win32_OperatingSystem | Select-Object -ExpandProperty InstallDate

# Extract device serial number
$serialNumber = Get-WmiObject -Class Win32_BIOS | Select-Object -ExpandProperty SerialNumber

# Extract BIOS version
$biosVersion = Get-WmiObject -Class Win32_BIOS | Select-Object -ExpandProperty BIOSVersion

# Display extracted information
Write-Output "Device Model: $computerModel"
Write-Output "CPU Model: $cpuInfo"
Write-Output "Operating System Install Date: $installDate"
Write-Output "Device Serial Number: $serialNumber"
Write-Output "BIOS Version: $biosVersion"

# Attempt to calculate device age using BIOS Release Date
$biosDate = Get-WmiObject -Class Win32_BIOS | Select-Object -ExpandProperty ReleasedDate

if ($biosDate) {
    try {
        $deviceAge = ((Get-Date) - [Management.ManagementDateTimeConverter]::ToDateTime($biosDate)).Days
        Write-Output "Approximate Device Age (based on BIOS release date): $([math]::Round($deviceAge / 365, 1)) years"
    } catch {
        Write-Output "Unable to calculate device age based on BIOS release date."
    }
} else {
    Write-Output "BIOS release date not available. Cannot calculate device age."
}
```

---
## 📁 Project Structure

```pgsql
device-info-extractor/  
├── Get-Device-Info.ps1  
└── README.md
```

---
  
**🛡️ Warning**  
⚠️ This script directly modifies Active Directory user attributes.  
Always test in a staging or development environment before using in production.  

---
  
**🤝 Contributing**  
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.  

---
  
📌 **Author**  
  Hamzeh Azari Hashjin  
  ☁️ Cloud & Systems Admin | 💻 12+ years in Hosting & Infrastructure  
  📍 Based in Montreal, Canada  
  🌐 LinkedIn Profile : https://www.linkedin.com/in/hamzeh-azari/  

---
  
**🛡️ License**  
      MIT License. Feel free to use, adapt and share with credit.

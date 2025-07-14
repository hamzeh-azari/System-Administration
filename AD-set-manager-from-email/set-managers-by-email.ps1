<#
.SYNOPSIS
Automatically sets managers for AD users based on a mapping provided in an Excel file.

.DESCRIPTION
This script reads an Excel file with employee and manager email addresses, then finds corresponding AD user accounts using the `mail` attribute, and sets the `manager` property accordingly.

.REQUIREMENTS
- ActiveDirectory module (RSAT)
- ImportExcel module (Install-Module ImportExcel)

.INPUT
An Excel file with two columns:
- EmployeeEmail
- ManagerEmail


.NOTES
    Author: Hamzeh Azari Hashjin
    Date: 2025-07-14
    Version: 1.0
    Requires: ActiveDirectory PowerShell module
#>

# Path to the Excel file (modify this as needed)
$excelFilePath = "C:\Path\To\Users.xlsx"

# Import Excel data into a variable
$users = Import-Excel -Path $excelFilePath

# Loop through each row in the Excel file
foreach ($entry in $users) {
    # Find the employee in AD by email
    $employee = Get-ADUser -Filter "mail -eq '$($entry.EmployeeEmail)'" -Properties mail

    # Find the manager in AD by email
    $manager = Get-ADUser -Filter "mail -eq '$($entry.ManagerEmail)'" -Properties mail

    # Proceed only if both employee and manager are found
    if ($employee -and $manager) {
        try {
            # Set the manager relationship
            Set-ADUser -Identity $employee -Manager $manager.DistinguishedName

            Write-Host "✅ Manager set: $($employee.SamAccountName) → $($manager.SamAccountName)"
        }
        catch {
            Write-Warning "❌ Failed to set manager for $($entry.EmployeeEmail): $_"
        }
    } else {
        if (-not $employee) {
            Write-Warning "⚠️ Employee not found: $($entry.EmployeeEmail)"
        }
        if (-not $manager) {
            Write-Warning "⚠️ Manager not found: $($entry.ManagerEmail)"
        }
    }
}

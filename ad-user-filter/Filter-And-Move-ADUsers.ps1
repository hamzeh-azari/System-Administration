<#
.SYNOPSIS
    Filters Active Directory users based on keywords in their description, moves them to a specified OU,
    and exports a report to Excel.

.DESCRIPTION
    This script searches all Active Directory users for specific keywords in the 'Description' field.
    Matching users are moved to a designated Organizational Unit (OU), and a summary report is generated
    and exported to an Excel file using the ImportExcel module.

    All company-specific details (e.g., OU paths, job titles, departments) should be customized before use.

.NOTES
    Author: Hamzeh Azari Hashjin
    Date: 2025-07-08
    Version: 1.0
    Requires: ActiveDirectory PowerShell module, ImportExcel module
    Run PowerShell as Administrator
#>

# Ensure ImportExcel module is available
if (-not (Get-Module -ListAvailable -Name ImportExcel)) {
    Install-Module -Name ImportExcel -Scope CurrentUser -Force
}

Import-Module ImportExcel
Import-Module ActiveDirectory

# Define the target OU (update this to match your environment)
$targetOU = "OU=TargetGroup,DC=example,DC=com"

# Define keywords to search for in the Description field
$keywords = @("keyword1", "keyword2", "keyword3")

# Retrieve users whose Description contains any of the keywords
$usersToMove = Get-ADUser -Filter * -Properties Description, MobilePhone, OfficePhone, Title, Department, Company | Where-Object {
    $desc = $_.Description
    if ($desc) {
        $descLower = $desc.ToLower()
        $keywords | Where-Object { $descLower -like "*$_*" }
    } else {
        $false
    }
}

# Prepare output data
$output = foreach ($user in $usersToMove) {
    try {
        Move-ADObject -Identity $user.DistinguishedName -TargetPath $targetOU
        $movedStatus = "Moved"
    }
    catch {
        $movedStatus = "Failed: $_"
    }

    [PSCustomObject]@{
        Name              = $user.Name
        SamAccountName    = $user.SamAccountName
        Description       = $user.Description
        MobilePhone       = $user.MobilePhone
        OfficePhone       = $user.OfficePhone
        JobTitle          = $user.Title
        Department        = $user.Department
        Company           = $user.Company
        DistinguishedName = $user.DistinguishedName
        MovedStatus       = $movedStatus
    }
}

# Export results to Excel
$excelPath = "$PWD\FilteredUsers_Report.xlsx"
$output | Export-Excel -Path $excelPath -AutoSize -WorksheetName "FilteredUsers"

Write-Host "Done! Report saved to:`n$excelPath"

<#
.SYNOPSIS
Export detailed Active Directory user and manager information to Excel.

.DESCRIPTION
Collects user details including name, email, phone number, department, job title, and manager info from Active Directory.
Exports the data into a formatted Excel file using ImportExcel module.

.AUTHOR
Hamzeh Azari
#>

# Ensure ImportExcel module is available
# Install-Module ImportExcel -Scope CurrentUser

# Get all enabled AD users with required properties
$users = Get-ADUser -Filter { Enabled -eq $true } -Properties `
    DisplayName, GivenName, Surname, Office, mail, telephoneNumber, `
    SamAccountName, Description, Department, Company, Title, Manager

# Create an array to store export objects
$exportData = @()

foreach ($user in $users) {
    $managerName = ""
    $managerID = ""

    if ($user.Manager) {
        $manager = Get-ADUser -Identity $user.Manager -Properties DisplayName, Office
        if ($manager) {
            $managerName = $manager.DisplayName
            $managerID   = $manager.Office
        }
    }

    # Add user details to the export list
    $exportData += [PSCustomObject]@{
        EmployeeName     = $user.DisplayName
        FirstName        = $user.GivenName
        LastName         = $user.Surname
        Email            = $user.mail
        PhoneNumber      = $user.telephoneNumber
        Username         = $user.SamAccountName
        Description      = $user.Description
        Department       = $user.Department
        Organization     = $user.Company
        JobTitle         = $user.Title
        EmployeeID       = $user.Office
        ManagerName      = $managerName
        ManagerID        = $managerID
    }
}

# Export the collected data to Excel
$exportPath = "C:\AD_Employees_Detailed.xlsx"
$exportData | Export-Excel -Path $exportPath -AutoSize -Title "Detailed AD User Export"

Write-Host "✅ Export completed: $exportPath"

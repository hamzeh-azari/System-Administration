<#
.SYNOPSIS
    Checks a list of email addresses against Active Directory to determine if each exists
    and whether the corresponding account is enabled or disabled.

.DESCRIPTION
    This PowerShell script reads email addresses from a text file (one per line),
    checks if each exists in Active Directory by matching the EmailAddress attribute,
    and outputs the result (Found/Not Found, Enabled/Disabled).
    The results are displayed in a table and exported to a CSV file.

.PARAMETER emailListPath
    The full path to the input text file containing one email address per line.

.OUTPUT
    Table output in the console and a CSV file saved to disk.

.NOTES
    Author: Hamzeh Azari Hashjin
    Date: 2025-07-09
    Version: 1.0
    Requires: ActiveDirectory PowerShell module
    Run PowerShell as Administrator
#>

# Path to the file containing email addresses (one per line)
$emailListPath = "C:\emails.txt"

# Check if the email list file exists
if (!(Test-Path $emailListPath)) {
    Write-Host "Email list file not found: $emailListPath"
    exit
}

# Read all email addresses from the file
$emails = Get-Content $emailListPath

# Array to store results
$results = @()

# Loop through each email and check in Active Directory
foreach ($email in $emails) {
    $user = Get-ADUser -Filter {EmailAddress -eq $email} -Properties EmailAddress, Enabled

    if ($user) {
        $status = if ($user.Enabled) { "Enabled" } else { "Disabled" }
        $results += [PSCustomObject]@{
            Email   = $email
            Status  = "Found"
            Account = $status
        }
    }
    else {
        $results += [PSCustomObject]@{
            Email   = $email
            Status  = "Not Found"
            Account = "-"
        }
    }
}

# Display results in a table
$results | Format-Table -AutoSize

# Export results to a CSV file
$outputPath = "C:\AD_Email_Check_Result.csv"
$results | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8

Write-Host "`n Check completed. Results saved to:`n$outputPath"

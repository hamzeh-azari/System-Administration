## 📜 Final PowerShell File: `Format-AdPhoneNumbers.ps1`

<#
.SYNOPSIS
    Cleans and standardizes telephoneNumber and mobile attributes in Active Directory to the format (XXX) XXX-XXXX.

.DESCRIPTION
    This script retrieves all users from Active Directory, extracts digits from their telephoneNumber and mobile attributes,
    formats valid numbers to the North American standard, and updates the AD records accordingly.
    Only numbers with exactly 10 digits or 11 digits starting with '1' are processed.

.NOTES
    Author: Hamzeh Azari Hashjin
    Date: 2025-07-09
    Requires: ActiveDirectory PowerShell module
#>

Import-Module ActiveDirectory

# Get all users with telephoneNumber and mobile
$users = Get-ADUser -Filter * -Properties telephoneNumber, mobile

foreach ($user in $users) {
    # Handle telephoneNumber
    foreach ($attribute in @("telephoneNumber", "mobile")) {
        $rawNumber = $user.$attribute

        if (![string]::IsNullOrWhiteSpace($rawNumber)) {
            # Remove all non-digit characters
            $digits = ($rawNumber -replace '[^0-9]', '')

            # Handle numbers longer than 10 digits
            if ($digits.Length -gt 10) {
                if ($digits.Length -eq 11 -and $digits.StartsWith('1')) {
                    $digits = $digits.Substring(1)
                } else {
                    $digits = $digits.Substring($digits.Length - 10)
                }
            }

            # Skip if less than 10 digits
            if ($digits.Length -lt 10) {
                Write-Host "Skipped $($user.SamAccountName): Incomplete $attribute ($rawNumber)"
                continue
            }

            # Format number
            $formatted = "({0}) {1}-{2}" -f $digits.Substring(0,3), $digits.Substring(3,3), $digits.Substring(6,4)

            # Update only if different
            if ($formatted -ne $rawNumber) {
                Set-ADUser -Identity $user.DistinguishedName -Replace @{ $attribute = $formatted }
                Write-Host "Updated $($user.SamAccountName) [$attribute]: $formatted"
            }
        }
    }
}

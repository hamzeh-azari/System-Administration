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
            Email       = $email
            Status      = "Found"
            Account     = $status
        }
    }
    else {
        $results += [PSCustomObject]@{
            Email       = $email
            Status      = "Not Found"
            Account     = "-"
        }
    }
}

# Display results in a table
$results | Format-Table -AutoSize

# Optional: Export results to a CSV file
$outputPath = "C:\AD_Email_Check_Result.csv"
$results | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8
Write-Host "`nCheck completed. Results saved to: $outputPath"

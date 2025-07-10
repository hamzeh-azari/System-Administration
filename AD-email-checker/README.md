# AD Email Lookup & Status Checker

A PowerShell script that checks whether a list of email addresses exists in Active Directory (AD), and returns the **status of each account** (Enabled/Disabled/Not Found). Results are displayed in a table and optionally exported to a CSV file.

---

## 🔧 Features

- Reads email addresses from a text file (one per line)
- Searches Active Directory using `EmailAddress` attribute
- Identifies whether the account exists
- Shows whether the account is **enabled** or **disabled**
- Exports results to a `.csv` file

---

## 📦 Requirements

- PowerShell (Windows)
- ActiveDirectory module (`Import-Module ActiveDirectory`)
- Read access to AD (Domain joined machine)
- Email list file (`emails.txt`)

---

## 🗂 Input Format

Your `emails.txt` should contain **one email address per line** like:

john.doe@example.com
jane.smith@example.com
someone@company.org

## 🚀 Usage

1. Save your list of emails to a file, e.g. `C:\emails.txt`.

2. Open PowerShell as Administrator.

3. Run the script:
   ```powershell
   .\Check-AD-Emails.ps1
   ```

4. After execution, the results will be displayed in a table and saved to:

   ```makefile
C:\AD_Email_Check_Result.csv
   ```

🧾 Sample Script
   ```powershell
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

   ```

📁 Project Structure
```sql
ad-email-checker/  
├── Check-AD-Emails.ps1  
└── README.md
```

  
**🛡️ Warning**  
⚠️ This script directly modifies Active Directory user attributes.  
Always test in a staging or development environment before using in production.  
  
**🤝 Contributing**  
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.  
  
📌 **Author**  
Hamzeh Azari Hashjin  
  ☁️ Cloud & Systems Admin | 💻 12+ years in Hosting & Infrastructure  
  📍 Based in Montreal, Canada  
  🌐 LinkedIn Profile : https://www.linkedin.com/in/hamzeh-azari/  
  
**🛡️ License**  
      MIT License. Feel free to use, adapt and share with credit.

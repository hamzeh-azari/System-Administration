# 📌 Set Active Directory Managers Using Email Mapping

This project includes a PowerShell script to automatically set managers for users in Active Directory based on their email addresses using data from an Excel file.

It’s ideal for HR-driven or automated onboarding scenarios where both user and manager emails are available.

---

## 📁 Project Structure

```
set-ad-manager-from-email/
├── set-managers-by-email.ps1     # Main script for assigning managers
├── sample-users.xlsx             # Sample Excel file (optional for testing)
└── README.md                     # This file
```

---

## 📊 Excel File Format

| EmployeeEmail         | ManagerEmail          |
|-----------------------|-----------------------|
| alice@company.com     | boss1@company.com     |
| bob@company.com       | boss2@company.com     |
| charlie@company.com   | boss1@company.com     |

- The script looks up both users using the `mail` field in Active Directory.
- Make sure `mail` values in AD are unique and match those in the Excel.

---

## 🔧 Requirements

- PowerShell 5.1 or later
- RSAT with ActiveDirectory module installed
- [ImportExcel](https://www.powershellgallery.com/packages/ImportExcel/) module

Install the Excel module if needed:

```powershell
Install-Module ImportExcel -Scope CurrentUser -Force
```

---

## ▶️ How to Use

1. Edit the script to point to your Excel file:
   ```powershell
   $excelFilePath = "C:\Path\To\Users.xlsx"
   ```

2. Run the script in PowerShell (with AD access):

   ```powershell
   .\set-managers-by-email.ps1
   ```

---

## ✅ Example Output

```text
✅ Manager set: jdoe → rboss
⚠️ Manager not found: unknown.manager@example.com
```

---

## 💡 Notes

- Test in a dev/staging environment before applying to production.
- You can easily extend this script to log results to a file or export to CSV.
- Useful in HR automation pipelines, onboarding flows, or migration cleanup tasks.


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


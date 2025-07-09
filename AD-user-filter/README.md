# AD User Filter & Move with Excel Report

A PowerShell script that filters Active Directory users based on keywords in their **Description** field, moves matching users to a target **Organizational Unit (OU)**, and exports a full report to Excel using the `ImportExcel` module.

---

## 🔧 Features

- Scans all AD users for specific **keywords** in the `Description` field
- Moves matching users to a specified **OU**
- Logs full user details (including status) into an **Excel report**
- Handles errors gracefully and reports them per user
- Fully customizable keywords, OU path, and exported fields

---

## 📦 Requirements

- PowerShell (Windows)
- ActiveDirectory module
- [ImportExcel PowerShell module](https://github.com/dfinke/ImportExcel)
- Admin privileges to read/write AD objects

---

1. Customize the following variables inside the script:
- $targetOU → your destination OU path
- $keywords → list of keywords to search for in user descriptions
2. Run PowerShell as Administrator and execute:
```powershell
.\Filter-And-Move-ADUsers.ps1
```
4. After execution, an Excel file like FilteredUsers_Report.xlsx will be created in the script folder.

📁 Project Structure
```pgsql  
ad-user-filter/  
├── Filter-And-Move-ADUsers.ps1  
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

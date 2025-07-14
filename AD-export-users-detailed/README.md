# 📊 Export Detailed AD Users and Managers to Excel

This PowerShell script collects and exports detailed information about enabled Active Directory users and their managers.  
It includes fields such as full name, email, phone number, department, title, and more — all saved into a neatly formatted Excel file.

---

## 📁 Project Structure

```
export-ad-users-detailed/
├── export-detailed-users.ps1       # Main script
├── AD_Employees_Detailed.xlsx      # Sample output (generated)
└── README.md                       # This file
```

---

## 📋 Output Fields

| Field          | Description                                |
|----------------|--------------------------------------------|
| EmployeeName   | Full name of the user                      |
| FirstName      | Given name                                 |
| LastName       | Surname                                    |
| Email          | User's email address                       |
| PhoneNumber    | User's phone number (from telephoneNumber) |
| Username       | SamAccountName (logon username)            |
| Description    | Description field from AD                  |
| Department     | Department name                            |
| Organization   | Company field in AD                        |
| JobTitle       | Title field in AD                          |
| EmployeeID     | Value from `Office` field                  |
| ManagerName    | Display name of the user's manager         |
| ManagerID      | Office value of the manager                |

---

## 🔧 Requirements

- PowerShell 5.1 or higher
- Active Directory RSAT tools
- [ImportExcel](https://www.powershellgallery.com/packages/ImportExcel/) PowerShell module

Install the required Excel module:

```powershell
Install-Module ImportExcel -Scope CurrentUser -Force
```

---

## ▶️ How to Use

1. Set the desired export path in the script (default is):

```powershell
$exportPath = "C:\AD_Employees_Detailed.xlsx"
```

2. Run the script in PowerShell (as a domain user with read access to AD):

```powershell
.\export-detailed-users.ps1
```

3. Open the exported Excel file and review all user and manager details.

---

## 💡 Notes

- The script assumes the `Office` attribute stores an Employee ID or similar unique identifier.
- Fields that are empty in AD will show blank in Excel.
- You can extend this to filter by OU, group membership, or include disabled accounts if needed.

---

## 📬 Contact

For improvements or feedback, feel free to open an issue or connect via GitHub.  
Happy scripting!

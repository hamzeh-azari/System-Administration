# AD Phone Formatter

A PowerShell script to automatically clean and standardize phone and mobile numbers in Active Directory (AD) to the North American format: `(XXX) XXX-XXXX`.

## 🔧 Features

- Formats both `telephoneNumber` and `mobile` attributes.
- Removes non-digit characters (e.g., spaces, dashes, parentheses).
- Handles 11-digit numbers starting with '1' by trimming the first digit.
- Ignores invalid or incomplete numbers.
- Only updates numbers if the formatted value is different from the existing one.

## 📦 Requirements

- PowerShell
- ActiveDirectory PowerShell module
- Appropriate permissions to read and write user attributes in AD

1. Navigate into the project folder:
  ```powershell
     Install-Module -Name ImportExcel -Scope CurrentUser -Force
  ```
2. Open PowerShell as Administrator.

3. Run the script:
  ```powershell
  .\Format-AdPhoneNumbers.ps1
   ```

🗂 **File Structure**
- ad-phone-formatter/
- ├── Format-AdPhoneNumbers.ps1   # The main script to clean AD phone numbers
- └── README.md                   # Project documentation

**🛡️ Warning**
⚠️ This script directly modifies Active Directory user attributes.
Always test in a staging or development environment before using in production.

**🤝 Contributing**
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

📌 **Author**
Hamzeh Azari Hashjin
- ☁️ Cloud & Systems Admin | 💻 12+ years in Hosting & Infrastructure
- 📍 Based in Montreal, Canada
- 🌐 LinkedIn Profile : https://www.linkedin.com/in/hamzeh-azari/

**🛡️ License**
- MIT License. Feel free to use, adapt and share with credit.

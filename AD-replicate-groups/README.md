# Replicate AD User Group Memberships

A simple but powerful PowerShell script to **replicate group memberships** from one Active Directory (AD) user to another. Ideal for IT teams handling user onboarding, role transitions, or cloning access rights between accounts.

---

## 🔧 Features

- Copies all `group memberships` from one AD user to another.
- Fast and effective for replicating access.
- Prevents manual group assignment errors.
- Fully compatible with role-based access practices.

---

## 📦 Requirements

- PowerShell (Windows)
- ActiveDirectory module (`Import-Module ActiveDirectory`)
- Admin privileges to modify group memberships

---

1. Open PowerShell as Administrator.  
2. Run the script with parameters:  

```powershell
.\Replicate-ADUserGroupMemberships.ps1 -oldUser jdoe -newUser jsmith
```
3. Alternatively, modify the variables directly inside the script:
```powershell
$oldUser = "jdoe"
$newUser = "jsmith"
```

📁 Project Structure
```sql
ad-replicate-groups/  
├── Replicate-ADUserGroupMemberships.ps1  
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

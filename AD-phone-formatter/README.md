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

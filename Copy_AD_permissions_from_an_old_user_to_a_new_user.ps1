# If you're a system administrator or technical support analyst, you might need to replicate all permissions from an existing user to a newly created one. With the simple PowerShell script below, you can easily achieve this within Active Directory.
# Note: Make sure to run PowerShell as Administrator (elevated mode).

$oldUser = "OldUserName"
$newUser = "NewUserName"
$groups = Get-ADUser $oldUser -Property MemberOf | Select-Object -ExpandProperty MemberOf
foreach ($group in $groups) {
    Add-ADGroupMember -Identity $group -Members $newUser
}

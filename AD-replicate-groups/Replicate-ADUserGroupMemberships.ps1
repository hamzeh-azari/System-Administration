<#
.SYNOPSIS
    Replicates group memberships from one Active Directory user to another.

.DESCRIPTION
    This PowerShell script is designed for system administrators and IT support professionals
    who need to replicate group memberships from an existing AD user to a new user.
    It retrieves all groups the source user is a member of and adds the target user to the same groups.
    This is especially useful for onboarding scenarios or role-based access replication.

.PARAMETER oldUser
    The sAMAccountName of the source user whose group memberships will be copied.

.PARAMETER newUser
    The sAMAccountName of the target user who will be added to the same groups.

.EXAMPLE
    .\Replicate-ADUserGroupMemberships.ps1 -oldUser jdoe -newUser jsmith

.NOTES
    Author: Hamzeh Azari Hashjin
    Date: 2025-07-08
    Version: 1.0
    Requires: ActiveDirectory PowerShell module
#>

$oldUser = "OldUserName"
$newUser = "NewUserName"

# Get all groups the old user is a member of
$groups = Get-ADUser $oldUser -Property MemberOf | Select-Object -ExpandProperty MemberOf

# Add the new user to each group
foreach ($group in $groups) {
    Add-ADGroupMember -Identity $group -Members $newUser
}

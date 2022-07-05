<#
.Synopsis
   Generate hash from string
.DESCRIPTION
   Generates a short hash (5 first characters) from the part of the string that comes after the last forward slash (/)
.EXAMPLE
   Given "features/SIL-1" will use "SIL-1" as input for the hash function and create a 5 character output from that
#>

param(
    [string]$stringToHash
)

# Take the last part of the string
$lastPartOfString =$stringToHash.Split("/")[-1]

# Calculate hash
$hash=[System.Security.Cryptography.HashAlgorithm]::Create("sha256").ComputeHash(
[System.Text.Encoding]::UTF8.GetBytes($lastPartOfString))

# Convert to hex
$longhash=[System.BitConverter]::ToString($hash).Replace("-","").ToLower()

# Create short hash
$shorthash=$longhash.SubString(0,5)
Write-Output "$shorthash Run from master"

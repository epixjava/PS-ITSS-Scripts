<#      
    Written by MJ Lema -2023
	Version 3.0 
	Get ADGroup Emails 
	Changelog - V2 added the ability to name csv. V3 added error checking for said csv
#>		


$name = Read-Host -Prompt "Please Enter AD Group " # Prompts user for Input
$csvFileName = Read-Host -Prompt "Please Enter a Name for the CSV File" # Prompt for CSV file name
$outputPath = "C:\$csvFileName.csv" # Defines the output path including the filename

Get-ADGroupMember -Identity $name -Recursive | # Searches all child groups
Get-ADUser -Properties Mail | # Searches for email
Select-Object Name, Mail |
Export-CSV -Path $outputPath -NoTypeInformation # Exports CSV to the specified path

if (Test-Path $outputPath) {
    Write-Host "Emails have been exported successfully to $outputPath." # Error checking
} else {
    Write-Host "Error: CSV file was not created."
}

Read-Host -Prompt "Please press enter to exit."

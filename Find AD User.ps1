<#      Written by MJ Lema -2023
	Version 1.0 
	Finds the AD User and gives last password reset date
#>		

$name= Read-Host -Prompt "Please Enter AD user name "
Get-ADUser $name  -Properties PwdLastSet
Read-Host -Prompt "Press Enter to Exit" 
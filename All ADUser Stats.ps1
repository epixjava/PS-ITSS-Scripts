<#  Written by MJ Lema -2023
	Version 1.0 
	Get All ADUser Stats
#>		

$name= Read-Host -Prompt "Please Enter AD USer name "
Get-ADUser $name  -Properties * #Just dumps all properties of the user...so many
Read-Host -Prompt "Press Enter to Exit" 
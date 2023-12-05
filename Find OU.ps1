<#      Written by MJ Lema -2023
	Version 1.0 
	Find the OU of a Computer
#>		


$name= Read-Host -Prompt "Please Enter the Device name" 
Get-ADComputer -Identity $name 
Read-Host -Prompt "Press Enter to Exit" 
<#
    Written by MJ Lema 2023
    Version 2 
    Get Devices from OU

#>
    $ou = Read-host "Enter the Fully Qualified domain name of the OU you want to search."
    $ncsv = Read-host "Name your csv"
    Get-ADComputer -Filter * -SearchBase "$ou" -Properties *  |
    Select -Property Name,DNSHostName,Enabled,LastLogonDate | 
    Export-CSV "C:\$ncsv.csv" -NoTypeInformation -Encoding UTF8

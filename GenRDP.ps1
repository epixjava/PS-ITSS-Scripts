<#      
    Written by MJ Lema - Jan 2024
	Version 3.0 
	Generate RDP Files based on OU
#>		


# Prompt user for the Active Directory OU
$ou = Read-Host "Enter the Active Directory OU in FQDN format"

# Define the folder path to save RDP files
$folderPath = "C:\RDPFiles\$ou"

# Create the folder if it doesn't exist
if (-not (Test-Path -Path $folderPath)) {
    New-Item -ItemType Directory -Path $folderPath -Force
}

# Get the computers from the specified OU and its child OUs
$computers = Get-ADComputer -Filter * -SearchBase $ou -SearchScope Subtree

# Loop through each computer and create RDP config file
foreach ($computer in $computers) {
    $computerName = $computer.Name
    $ipAddress = [System.Net.Dns]::GetHostAddresses($computerName) | Where-Object { $_.AddressFamily -eq 'InterNetwork' } | Select-Object -ExpandProperty IPAddressToString

    # Generate RDP configuration file, add values here to adjust settings
    $rdpContent = @"
full address:s:$computerName.arusd.org
prompt for credentials:i:1
gatewayhostname:s:
gatewayusagemethod:i:4
gatewaycredentialssource:i:4
negotiate security layer:i:1
disable connection sharing:i:0
enablecredsspsupport:i:1
authentication level:i:2
promptcredentialonce:i:0
drivestoredirect:s:
username:s:
"@

    # Save RDP configuration to a file
    $rdpFilePath = Join-Path -Path $folderPath -ChildPath "$computerName.rdp"
    Set-Content -Path $rdpFilePath -Value $rdpContent

    Write-Host "RDP configuration file created for $computerName at $rdpFilePath"
}

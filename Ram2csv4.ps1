<# 
    Written by MJ Lema - 2023
    Ram info to CSV 
    Version 4

    Changlog: 
    V1 - Queries Ram of device in OU, 
    V2 - Added user defined OU and CSV path, 
    V3 - Added Error Checking, 
    V4 - Bug fixes 

#>

# Prompts the user for the FQD OU name
$ouPath = Read-Host "Enter the OU path (example: OU=Computers,DC=YourDomain,DC=com)"

# Validates the OU path 
if (-not $ouPath -or $ouPath -notmatch "^OU=.+,DC=.+,DC=.+$") {
    Write-Host "Invalid OU path. Please provide a valid OU path. Must be in FQD format"
    exit
}

# Prompts the user for the CSV file path and name
$outputCsvPath = Read-Host "Enter the CSV file path (example: C:\Path\To\Output\ComputersRAM.csv)"

# Inform the user that the script has started
Write-Host "Script is now retrieving RAM information for computers in $ouPath. This may take some time..."

# Retrieve computers from the specified OU
$computers = Get-ADComputer -Filter * -SearchBase $ouPath -Properties Name

# Creates an array to store results
$results = @()

# Loop through each computer and retrieve RAM information
foreach ($computer in $computers) {
    $computerName = $computer.Name
    $computerInfo = [PSCustomObject]@{
        'ComputerName' = $computerName
        'TotalRAM_GB'   = $null
    }
	#try catch to ignore devices that return an error
    try {
        # Query CIMInstance to get RAM information
        $ramInfo = Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $computerName -ErrorAction Stop

        # Update the RAM information
        $computerInfo.TotalRAM_GB = $ramInfo.TotalPhysicalMemory / 1GB
    } catch {
        Write-Host "Error retrieving information for computer $($computerName): $_"
    }

    # Add the object to the results array
    $results += $computerInfo
}

# Export results to CSV
$results | Export-Csv -Path $outputCsvPath -NoTypeInformation

# Check if the CSV file was generated
if (Test-Path $outputCsvPath) {
    Write-Host "RAM information for computers in $ouPath exported to $outputCsvPath"
} else {
    Write-Host "Error: CSV file could not be generated. Please check the script and try again."
}

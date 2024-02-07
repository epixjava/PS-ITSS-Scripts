<#      
    Written by MJ Lema - Feb 2024
	Version 3.0 
	AD Search. Combination of 3 scripts into one. Gives the user two choices, 
    the option to search for an AD User or a Computer name to get OU/Properties info. 
#>		


function Search-AD {
    # Prompt the user to choose whether to search by AD username or Computer name
    $choice = Read-Host -Prompt "Enter '1' to search by AD username, '2' to search by Computer name, or 'q' to quit"

    if ($choice -eq '1') {
        # Search by AD username
        $name = Read-Host -Prompt "Please enter the AD username"
        $properties = "*"
        $allProperties = Read-Host -Prompt "Do you want to retrieve all AD user properties? (Y/N)"
        if ($allProperties -eq 'Y' -or $allProperties -eq 'y') {
            $properties = "*"
        } else {
            $properties = "PwdLastSet" # Default property
        }
        Get-ADUser $name -Properties $properties
    } elseif ($choice -eq '2') {
        # Search by Computer name
        $name = Read-Host -Prompt "Please enter the Computer name"
        Get-ADComputer -Identity $name
    } elseif ($choice -eq 'q') {
        return # Exit the function if the user chooses to quit
    } else {
        Write-Host "Invalid choice. Please enter '1' or '2' to search or 'q' to quit." -ForegroundColor Red
        return
    }

    # Prompt the user if they want to search again
    $searchAgain = Read-Host -Prompt "Do you want to search again? (Y/N)"

    if ($searchAgain -eq 'Y' -or $searchAgain -eq 'y') {
        Search-ADObjects # Run the search function again
    } else {
        Write-Host "Exiting..." -ForegroundColor Green
    }
}

# Call the function to start searching
Search-AD


# Enter Y to start another search or Q to quit.
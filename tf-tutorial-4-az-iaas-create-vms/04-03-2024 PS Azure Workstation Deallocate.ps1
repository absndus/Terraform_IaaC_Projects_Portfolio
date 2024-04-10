# File: 04-03-2024 PS Azure Workstation Deallocate.ps1
# Date: 04/03/2024
# Author: Albert Schultz
# Type: PowerShell Script
# Note: This PowerShell script completely turns off the VMs. 

# Deallocate the VMs. 
az vm start --name absdevopsrhelwkstn1 --resource-group absdevopsrhelwkstn1rg
az vm deallocate --name absdevopsrhelwkstn2 --resource-group absdevopsrhelwkstn2rg
az vm deallocate --name absdevopsrhelwkstn3 --resource-group absdevopsrhelwkstn3rg

# View current VM's status as a table. 
az vm list -d --query "[].{Name:name, Status:powerState}" -o table
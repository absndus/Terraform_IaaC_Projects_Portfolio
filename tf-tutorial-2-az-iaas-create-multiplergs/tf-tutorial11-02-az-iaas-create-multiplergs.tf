# File: tf-tutorial11-02-az-iaas-create-multiplergs.tf
# Author: Albert B. Schultz
# Version: 1.00
# Date: 03/04/2024
# Type: Terraform Script
# Target Systems: Azure IaaS Cloud
# Description: Contains the ability to create Azure Resource Groups using for loops. 

# Create the resource-groups in a for loop based on the variables data in variables.tf. 

resource "azurerm_resource_group" "rgroups" {
  count    = length(var.rgnames)
  name     = var.rgnames[count.index]
  location = "centralus" 
}
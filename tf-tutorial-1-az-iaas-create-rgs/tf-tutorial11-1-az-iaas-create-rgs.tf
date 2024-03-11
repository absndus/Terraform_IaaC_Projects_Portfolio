# File: tf-tutorial11-1-az-iaas-create-rgs.tf
# Author: Albert B. Schultz
# Version: 1.00
# Date: 03/04/2024
# Type: Terraform Script
# Target Systems: Azure IaaS Cloud
# Description: Contains the ability to create Azure Resource Groups using the variable tf file. 

# Create the resource-groups. 
resource "azurerm_resource_group" "rg1" {
  name     = "rg1"
  location = "centralus"
}

resource "azurerm_resource_group" "compute1rg" {
  name = "compute1rg"
  location = "centralus"
}
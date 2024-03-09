# File: tf-tutorial11-3-az-iaas-create-vnet-subnets-nsg.tf
# Author: Albert B. Schultz
# Version: 1.00
# Date: 03/04/2024
# Type: Terraform Script
# Target Systems: Azure IaaS Cloud
# Description: Contains the ability to create Azure Virtual Network (VNET) and its subnets along with the nsg that block traffic from going between subnets. To allow traffic through, please specify the source and destination within the NVA instead of through Azure NSGs.  

# Create the resource-group using loop variable for the VNET and its subnets. 
resource "azurerm_resource_group" "rgroups" {
  count    = length(var.rgnames)
  name     = var.rgnames[0]
  location = "centralus"
}

# Create the VNETs. 
resource "azurerm_virtual_network" "vnets" {
  count               = length(var.vnetnames)
  name                = var.vnetnames[0]
  location            = "centralus"
  resource_group_name = azurerm_resource_group.rgroups[0].name
  address_space       = [var.vnetipspace[0]]
}

# Create the VNET's subnets. 
resource "azurerm_subnet" "absdevopsvnetsubs" {
  count                = length(var.vnetsubnames)
  name                 = var.vnetsubnames[count.index]
  resource_group_name  = azurerm_resource_group.rgroups[0].name
  virtual_network_name = azurerm_virtual_network.vnets[0].name
  address_prefixes     = [var.vnetsubippref[count.index]]
}

# Create a Network Security Group.
resource "azurerm_network_security_group" "nsg" {
  name                = "absnsg"
  location            = "centralus"
  resource_group_name = azurerm_resource_group.rgroups[0].name
}

# Define a security rule to deny traffic between subnets. 
resource "azurerm_network_security_rule" "deny_subnet_to_subnet" {
  name                        = "DenySubnetToSubnet"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefixes     = ["10.0.0.0/26", "10.0.1.0/26", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
  destination_address_prefixes = ["10.0.0.0/26", "10.0.1.0/26", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
  resource_group_name         = azurerm_resource_group.rgroups[0].name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# Associate NSG with the subnets within the VNET. 
resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  count                     = length(azurerm_subnet.absdevopsvnetsubs)
  subnet_id                 = azurerm_subnet.absdevopsvnetsubs[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
# File: az-iaas-create-vnet-subnets-main.tf
# Author: Albert B. Schultz
# Version: 1.00
# Date: 03/08/2024
# Type: Terraform Script
# Target Systems: Azure IaaS Cloud
# Description: Creates the VNET, subnets, rgs, and NSGs.

# Create the resource-group for the VNET. 
resource "azurerm_resource_group" "rgroups" {
  count    = length(var.rgnames)
  name     = var.rgnames[0]
  location = var.azloc[0]
}

# Create the VNETs. 
resource "azurerm_virtual_network" "vnets" {
  count               = length(var.vnetnames)
  name                = var.vnetnames[0]
  location            = var.azloc[0]
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
  location            = var.azloc[0]
  resource_group_name = azurerm_resource_group.rgroups[0].name
}

# Define a security rule to deny traffic between subnets. 
# Placeholder

# Associate NSG with the subnets within the VNET. 
# Placeholder

# Create the resource-groups using loop variable for the Linux and or Windows VMs. 
resource "azurerm_resource_group" "vmrgroups" {
  count    = length(var.vmrgroups)
  name     = var.vmrgroups[count.index]
  location = var.azloc[0]
}

# Create the required public NIC cards for the VMs. 
resource "azurerm_public_ip" "public_ip_nic_vm" {
  count               = length(var.vmnames)
  name                = "${var.vmnames[count.index]}-pnic"
  resource_group_name = azurerm_resource_group.vmrgroups[count.index].name
  location            = var.azloc[0]
  allocation_method   = "Dynamic"
}

# Create the required internal NIC cards for the VMs. 
resource "azurerm_network_interface" "main" {
  count               = length(var.vmnames)
  name                = "${var.vmnames[count.index]}-inic"
  resource_group_name = azurerm_resource_group.vmrgroups[count.index].name
  location            = var.azloc[0]

  ip_configuration {
    name                          = "${var.vmnames[count.index]}-i-ip"
    subnet_id                     = azurerm_subnet.absdevopsvnetsubs[2].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_nic_vm[count.index].id
  }
}

# Create a NSG that is tied to the VMs' NIC card. 
resource "azurerm_network_security_group" "nsg2" {
  name                = "absvmnicnsg"
  location            = var.azloc[0]
  resource_group_name = azurerm_resource_group.rgroups[0].name
  security_rule {
    name                       = "AllowHTTPS"
    description                = "Allow HTTPS"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTP"
    description                = "Allow HTTP"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowSSH"
    description                = "Allow SSH"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

# Associate NSG with the VM's nic cards. This is a test. Test
resource "azurerm_network_interface_security_group_association" "nsg_association2" {
  count                     = length(var.vmnames)
  network_interface_id      = azurerm_network_interface.main[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg2.id
}
# File: az-iaas-create-rhelvms-main.tf
# Author: Albert B. Schultz
# Version: 1.00
# Date: 03/04/2024
# Type: Terraform Script
# Target Systems: Azure IaaS Cloud
# Description: Contains the ability to create VMs on the existing Azure VNET and subnets with the already existing VNET and subnet/nsg.  

# Create the required VMs within the Azure VNET Subnet, absdevopvnetprimary/absdevopsvnetclientwkstnsub subnet. 
resource "azurerm_linux_virtual_machine" "main" {
  count                           = length(var.vmnames)
  name                            = "${var.vmnames[count.index]}"
  resource_group_name             = azurerm_resource_group.vmrgroups[count.index].name
  location                        = var.azloc[0]
  size                            = "Standard_D1_v2"
  admin_username                  = var.vm_username
  admin_password                  = var.vm_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.main[count.index].id,
  ]

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "8-LVM"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  # Push out updates to the RHEL 8 VMs. 
  # custom_data = base64encode(data.template_file.linux-vm-cloud-init.rendered)
}

# Template for bootstrapping and updating the newly created Azure RHEL VMs. 
#data "template_file" "linux-vm-cloud-init" {
  # template = file("az-iaas-rhel-user-complete.sh")
# }
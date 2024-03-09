output "resource_group_name" {
  description = "The name of the created resource group."
  value       = azurerm_resource_group.rgroups[0]
}

output "virtual_network_name" {
  description = "The name of the created virtual network."
  value       = azurerm_virtual_network.vnets[0]
}

output "subnet_name_1" {
  description = "The name of the created subnet 1."
  value       = var.vnetsubnames[0]
}

output "subnet_name_2" {
  description = "The name of the created subnet 2."
  value       = var.vnetsubnames[1]
}

output "subnet_name_3" {
  description = "The name of the created subnet 3."
  value       = var.vnetsubnames[2]
}
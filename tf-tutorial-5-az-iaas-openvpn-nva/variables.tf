# File: variables.tf
# Author: Albert B. Schultz
# Version: 1.00
# Date: 03/08/2024
# Type: Terraform Script
# Target Systems: Azure IaaS Cloud
# Description: Contains variables for the primary tf file. You can specify name, network, and attributes of the VM in Azure IaaS Cloud. 

# Define the Azure physical location index.  
variable "azloc" {
  description = "Azure IaaS physical locations."
  type        = list(string)
  default     = ["centralus", "eastus", "northus"]
}

# Define the VNET resource-groups.  
variable "rgnames" {
  description = "Resource-group names for VNETs."
  type        = list(string)
  default     = ["absdevopsvnetrg"]
}

# Define the Virtual Machine (VM) resource-groups.  
variable "vmrgroups" {
  description = "Resource-group names for VMs."
  type        = list(string)
  default     = ["absdevopsrhelwkstn1rg", "absdevopsrhelwkstn2rg", "absdevopsrhelwkstn3rg"]
}

# Define the Virtual Machine (VM) names.  
variable "vmnames" {
  description = "Resource-group names for VMs."
  type        = list(string)
  default     = ["absdevopsrhelwkstn1", "absdevopsrhelwkstn2", "absdevopsrhelwkstn3"]
}

# Define the VNET names. 
variable "vnetnames" {
  description = "Virtual network names."
  type        = list(string)
  default     = ["absdevopvnetprimary"]
}

# Define the VNET's subnet names. 
variable "vnetsubnames" {
  description = "Virtual network subnet names."
  type        = list(string)
  default     = ["absdevopsvnetnetnvasub", "absdevopsvnetserverssub", "absdevopsvnetclientwkstnsub", "absdevopsvnetopenvpnclients", "absdevopsvnetcctvsub", "absdevopsvnetguestsub"]
}

# Define the VNET's subnets network IP prefixes. 
variable "vnetsubippref" {
  description = "Virtual network subnet IP network prefixes."
  type        = list(string)
  default     = ["10.0.0.0/26", "10.0.1.0/26", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
}

# Define the VNET's IP address spaces of choice.
variable "vnetipspace" {
  description = "Virtual network IP address space."
  type        = list(string)
  default     = ["10.0.0.0/16", "172.168.0.0/16", "192.168.0.0/24"]
}
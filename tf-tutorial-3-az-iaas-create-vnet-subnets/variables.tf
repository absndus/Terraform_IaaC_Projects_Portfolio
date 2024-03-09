# File: variables.tf
# Author: Albert B. Schultz
# Version: 1.00
# Date: 03/04/2024
# Type: Terraform Script
# Target Systems: Azure IaaS Cloud
# Description: Contains variables for the primary tf file. You can specify the proper names, the IP addresses, and the subnet names for your IaaS Cloud Infrastructure. 

# Create the required variables for the creation of a VNET and the subnets. 
variable "rgnames" {
  description = "Resource-group names."
  type        = list(string)
  default     = ["absdevopsvnetrg"]
}

variable "vnetnames" {
  description = "Virtual network names."
  type        = list(string)
  default     = ["absdevopvnetprimary"]
}

variable "vnetsubnames" {
  description = "Virtual network subnet names."
  type        = list(string)
  default     = ["absdevopsvnetnetnvasub", "absdevopsvnetserverssub", "absdevopsvnetclientwkstnsub", "absdevopsvnetopenvpnclients", "absdevopsvnetcctvsub", "absdevopsvnetguestsub"]
}

variable "vnetsubippref" {
  description = "Virtual network subnet IP network prefixes."
  type        = list(string)
  default     = ["10.0.0.0/26", "10.0.1.0/26", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
}

variable "vnetipspace" {
  description = "Virtual network IP address space."
  type        = list(string)
  default     = ["10.0.0.0/16", "172.168.0.0/16", "192.168.0.0/24"]
}
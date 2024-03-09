# File: variables.tf
# Author: Albert B. Schultz
# Version: 1.00
# Date: 03/04/2024
# Type: Terraform Script
# Target Systems: Azure IaaS Cloud
# Description: Contains variables for the primary tf file. 

# Create a resource-group variable names.
variable "rgnames" {
  description = "Resource-group names."
  type        = list(string)
  default     = ["rg1", "rg2", "rg3", "rg4"]
}
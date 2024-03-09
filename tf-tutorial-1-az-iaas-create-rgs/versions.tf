# File: versions.tf
# Author: Albert B. Schultz
# Version: 1.00
# Date: 03/04/2024
# Type: Terraform Script
# Target Systems: Azure IaaS Cloud
# Description: Contains version and provider data. 

terraform {

  cloud {
    organization = "absconsulting"

    workspaces {
      name = "abshometfdevopswkspce"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.10.0"
    }
  }

  required_version = ">= 1.2.3"
}

provider "azurerm" {
  features {}
}
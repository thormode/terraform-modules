provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.23.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tamopstfstates"
    storage_account_name = "testterraformtormod"
    container_name       = "tfstateakscluster"
    key                  = "tfstateakscluster.tfstate"
  }
}

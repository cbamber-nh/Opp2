terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
  backend "azurerm" {
    resource_group_name     = "__tfStateResourceGroup__"
    storage_account_name    = "__tfStateStorageAccount__"
    container_name          = "__tfStateContainerName__"
    key                     = "terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "opp2" {
  name                     = "__tfStorageAccount__"
  resource_group_name      = "__tfResourceGroup__"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  account_kind				= "StorageV2"

  static_website {
	index_document			= "index.html"
	error_404_document		= "index.html"
  }

  
  tags = local.tags_rebuildable_resource
}

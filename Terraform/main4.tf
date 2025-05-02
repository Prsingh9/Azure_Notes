# terraform script to create Storage account and container
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "prab01-rg"
  location = "Central India"
}

resource "azurerm_storage_account" "example" {
  name                     = "prabstorage"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  name                  = "prabcontainer"
  storage_account_name    = azurerm_storage_account.example.name
  container_access_type = "private"
}
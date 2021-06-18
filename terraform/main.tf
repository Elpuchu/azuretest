terraform {
  required_providers {
    azure = {
      source  = "hashicorp/azurerm"
      version = "=2.46.1"
    }
  }
}

# creación de resource group
resource "azurerm_resource_group" "aztrg" {
  name = "kubernetes_rg"
  location = var.location #definido en correccion.vars
  tags = {
    environment = "azurestest"
  }
}

# creación de storage account
resource "azurerm_storage_account" "aztStAcnt" {
    name                     = var.storage_account #definido en correccion.vars
    resource_group_name      = azurerm_resource_group.aztrg.name
    location                 = azurerm_resource_group.aztrg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"

    tags = {
        environment = "azurestest"
    }

}
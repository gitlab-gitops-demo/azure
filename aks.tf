provider "azurerm" {
    version = "=1.34.0"
}

resource "azurerm_resource_group" "gitops-demo" {
  name     = "gitops-demo"
  location = "West US 2"
}


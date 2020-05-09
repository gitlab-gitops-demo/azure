provider "azurerm" {
  version = "=2.9.0"
  features {}
}

resource "azurerm_resource_group" "gitops-demo" {
  name     = "gitops-demo"
  location = "West US 2"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "gitops-demo-aks"
  location            = azurerm_resource_group.gitops-demo.location
  resource_group_name = azurerm_resource_group.gitops-demo.name
  dns_prefix          = "gitlab"

  default_node_pool {
    name            = "default"
    node_count      = 3
    vm_size         = "Standard_F2s_v2"
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Terraform = "True"
  }
}

output "env-dynamic-url" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.host
}
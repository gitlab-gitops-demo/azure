terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    gitlab = {
      source = "terraform-providers/gitlab"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
  required_version = ">= 0.13"
}

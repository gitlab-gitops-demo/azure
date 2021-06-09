terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"

    }
    gitlab = {
      source = "gitlabhq/gitlab"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
  required_version = "~> 1.0.0"
}

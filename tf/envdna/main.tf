# Don't try to run this. It won't work.
# Backend config and variables get set 
# during the github actions workflow run.
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-spa-init-eus"
    storage_account_name = "saspastate"
    container_name       = "tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  use_oidc = true
  features {}
}

module "infrastructure" {
  source      = "../infrastructure"
  service     = var.service
  environment = var.environment
  region      = var.region
  domain      = var.domain
}
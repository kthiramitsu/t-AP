terraform {
    required_providers {
      azurerm = {
       source = "hashicorp/azurerm"
       version = "=2.46.0"
      }
    }
}

provider "azurerm" {
    features {}
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
}

terraform {
    required_version = ">=0.12"
}
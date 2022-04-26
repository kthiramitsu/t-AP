terraform {
    required_providers {
      azurerm = {
       source = "hashicorp/azurerm"
       version = "=2.46.0"
      }
    }

    backend "azurerm" {
        resource_group_name = "rg-for-storage"
        storage_account_name = "koehatesutodesuka"
        container_name = "tfstate"
        key = "terraform.tfstate"
        access_key = "x1zOX3Fdm5td3tkSa+f7N4eNOFEr5BZ+9Bgyts8Ioy08rOHda9PD5+Murbdhqiw5PEZqPVTgcH0M8GRdJmVM7w=="
      
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
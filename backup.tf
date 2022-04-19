/*コンテナー*/

resource "azurerm_recovery_services_vault" "vault" {
  name                = var.vault
  location            = var.location
  resource_group_name = var.rg
  sku                 = "Standard"

  soft_delete_enabled = true
}
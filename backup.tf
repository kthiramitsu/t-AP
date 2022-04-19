/*コンテナー*/

resource "azurerm_recovery_services_vault" "vault" {
  name                = var.vault
  location            = var.location
  resource_group_name = var.rg
  sku                 = "Standard"

  soft_delete_enabled = true
}

/*バックアップポリシー*/

resource "azurerm_backup_policy_vm" "vm_bup" {
  name = "backup-policy"
  resource_group_name = var.rg
  recovery_vault_name = var.vault

  timezone = "Tokyo Standard Time"

  backup {
    frequency = "Daily"
    time = "12:00"
  }

  instant_restore_retention_days = 3

  retention_daily {
    count = 100
  }
  
}

/*VMとポリシーの関連付け*/

resource "azurerm_backup_protected_vm" "vm-dev" {
  resource_group_name = var.rg
  recovery_vault_name = var.vault
  source_vm_id = azurerm_windows_virtual_machine.vm-dev.id
  backup_policy_id = azurerm_backup_policy_vm.vm_bup.id
}
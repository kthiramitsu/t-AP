/*Automation アカウント*/

resource "azurerm_automation_account" "Automation" {
  name = var.automation
  location = var.location
  resource_group_name = var.rg
  sku_name = "Basic"
}
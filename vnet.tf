resource "azurerm_virtual_network" "vnet" {
    name = var.vnet
    location = var.location
    resource_group_name = var.rg
    address_space       = ["10.5.0.0/16"]

}

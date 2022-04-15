/*Vnet*/
resource "azurerm_virtual_network" "vnet" {
    name = var.vnet
    location = var.location
    resource_group_name = var.rg
    address_space       = ["10.5.0.0/16"]

}

/*サブネット*/

resource "azurerm_subnet" "subnet-dev" {
    name                 = "${var.vnet}-subnet-dev"
    resource_group_name  = var.rg
    virtual_network_name = var.vnet
    address_prefixes     = ["10.5.1.0/24"]
}

resource "azurerm_subnet" "subnet-stg" {
    name                 = "${var.vnet}-subnet-stg"
    resource_group_name  = var.rg
    virtual_network_name = var.vnet
    address_prefixes     = ["10.5.2.0/24"]
}

resource "azurerm_subnet" "GatewaySubnet" {
    name                 = "GatewaySubnet"
    resource_group_name  = var.rg
    virtual_network_name = var.vnet
    address_prefixes     = ["10.5.3.0/24"]
}

/*ゲートウェイサブネット*/

resource "azurerm_virtual_network_gateway" "ERGW" {
    name                = var.ERGW
    location            = var.location
    resource_group_name = var.rg

    type     = "ExpressRoute"
    vpn_type = "RouteBased"

    sku           = "Standard"

    ip_configuration {
    name                          = "${var.ERGW}-pip"
    public_ip_address_id          = azurerm_public_ip.AP-ERGW-pip.id
    subnet_id                     = azurerm_subnet.GatewaySubnet.id
    }

    depends_on = [azurerm_public_ip.AP-ERGW-pip]

}

/*仮想ネットワークゲートウェイ用パブリックＩＰ
*/
resource "azurerm_public_ip" "AP-ERGW-pip" {
    name                = "${var.ERGW}-pip"
    location            = var.location
    resource_group_name = var.rg

    allocation_method = "Dynamic"
}
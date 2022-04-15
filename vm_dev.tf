/*NIC*/
resource "azurerm_network_interface" "vm-dev-nic" {
  name                = "${var.vm-dev}-nic"
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {
    name                          = "${var.vm-dev}-nic-ip"
    subnet_id                     = azurerm_subnet.subnet-dev.id
    private_ip_address_allocation = "Dynamic"
  }
}

/*WindowsVM用NSG*/
resource "azurerm_network_security_group" "vm-dev-nsg" {
  name                =  "${var.vm-dev}-nsg"
  location = var.location
  resource_group_name = var.rg

security_rule {
    name                       = "RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "vm-dev-nic" {
    network_interface_id      = azurerm_network_interface.vm-dev-nic.id
    network_security_group_id = azurerm_network_security_group.vm-dev-nsg.id
}

/*Windows仮想マシン*/
resource "azurerm_windows_virtual_machine" "vm-dev" {
  name                = var.vm-dev
  resource_group_name = var.rg
  location            = var.location
  size                = "Standard_B1ms"
  admin_username      = "adminuser"
  admin_password      = "Ne0sk.2613!$"
  network_interface_ids = [azurerm_network_interface.vm-dev-nic.id]

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer = "WindowsServer"
    sku = "2019-datacenter-gensecond"
    version = "latest"
  }

}
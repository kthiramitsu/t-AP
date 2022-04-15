/*NIC*/
resource "azurerm_network_interface" "vm-stg-nic" {
  name                = "${var.vm-stg}-nic"
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {
    name                          = "${var.vm-stg}-nic-ip"
    subnet_id                     = azurerm_subnet.subnet-stg.id
    private_ip_address_allocation = "Dynamic"
  }
}

/*WindowsVM用NSG*/
resource "azurerm_network_security_group" "vm-stg-nsg" {
  name                =  "${var.vm-stg}-nsg"
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

resource "azurerm_network_interface_security_group_association" "vm-stg-nic" {
    network_interface_id      = azurerm_network_interface.vm-stg-nic.id
    network_security_group_id = azurerm_network_security_group.vm-stg-nsg.id
}

/*Windows仮想マシン*/
resource "azurerm_windows_virtual_machine" "vm-stg" {
  name                = var.vm-stg
  resource_group_name = var.rg
  location            = var.location
  size                = "Standard_B1ms"
  admin_username      = "adminuser"
  admin_password      = "Ne0sk.2613!$"
  network_interface_ids = [azurerm_network_interface.vm-stg-nic.id]
 
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer = "WindowsServer"
    sku = "2019-datacenter-gensecond"
    version = "latest"
  }

}

/*Managed OSディスク*/
resource "azurerm_managed_disk" "disk-stg-1" {
  name = "${var.disk_stg}-01"
  location = var.location
  resource_group_name = var.rg
  storage_account_type = "StandardSSD_LRS"
  create_option = "Empty"
  disk_size_gb = "128"
}

resource "azurerm_managed_disk" "disk-stg-2" {
  name = "${var.disk_stg}-02"
  location = var.location
  resource_group_name = var.rg
  storage_account_type = "StandardSSD_LRS"
  create_option = "Empty"
  disk_size_gb = "128"
}

resource "azurerm_virtual_machine_data_disk_attachment" "stg_1" {
  managed_disk_id    = azurerm_managed_disk.disk-stg-1.id
  virtual_machine_id = azurerm_windows_virtual_machine.vm-stg.id
  lun                = "0"
  caching            = "ReadWrite"
}

resource "azurerm_virtual_machine_data_disk_attachment" "stg_2" {
  managed_disk_id    = azurerm_managed_disk.disk-stg-2.id
  virtual_machine_id = azurerm_windows_virtual_machine.vm-stg.id
  lun                = "1"
  caching            = "ReadWrite"
}
resource "azurerm_virtual_machine" "vm" {
  count               = 3
  name                = "vm-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  os_profile           = {
    computer_name = "vm-${count.index + 1}"
    admin_username = var.admin_username
    admin_password = var.admin_password
  } 
  os_profile_linux_config = {
    disable_password_authentication = false
  }
  storage_os_disk = {
    name              = "disk-${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed           = true
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_interface" "nic" {
  count               = 3
  name                = "nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "internal"
    subnet_id                    = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id         = azurerm_public_ip.pip[count.index].id
  }
}

resource "azurerm_public_ip" "pip" {
  count               = 3
  name                = "pip-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
}

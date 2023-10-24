module "general_module" {
    source=".././general"
    resource_group_name = var.resource_group_name
    location = var.location
}

resource "azurerm_network_interface" "db_interface" {
  name                = var.nic2
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.dbsubnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.dbip.id
  }

  depends_on = [ azurerm_public_ip.dbip ]
}

resource "azurerm_public_ip" "dbip" {
  name                = var.dbpublic_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic" 
}

resource "azurerm_network_interface" "web_interface" {
  name                = var.nic1
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.websubnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.webip.id
  }

  depends_on = [ azurerm_public_ip.webip ]
}


resource "azurerm_public_ip" "webip" {
  name                = var.webpublic_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic" 
}


resource "azurerm_windows_virtual_machine" "dbvm" {
  name                = var.dbvm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_D2s_v3"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.db_interface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftSQLServer"
    offer     = "sql2019-ws2019"
    sku       = "sqldev"
    version   = "15.0.220510"
  }
  depends_on = [ azurerm_network_interface.db_interface ]

}

resource "azurerm_windows_virtual_machine" "webvm" {
  name                = var.webvm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_D2s_v3"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.web_interface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
    source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacentre"
    version = "latest"
  }
  
  depends_on = [ azurerm_network_interface.web_interface ]
  
}
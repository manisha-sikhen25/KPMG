module "general_module" {
    source=".././general"
    resource_group_name = var.resource_group_name
    location = var.location
}


resource "azurerm_virtual_network" "network" {
  name = var.virtual_network_name
  location = var.location
  resource_group_name = var.resource_group_name
  address_space = [var.virtual_address_space]
  depends_on = [ 
    module.general_module.resourcegroup
   ]
}

resource "azurerm_subnet" "appsubnet" {
    name = var.app_subnet_name
    resource_group_name = var.resource_group_name
    virtual_network_name =   var.virtual_network_name
    address_prefixes = [ var.appsubnet_address_space  ]
    depends_on = [
        azurerm_virtual_network.network
     ]
}

resource "azurerm_subnet" "dbsubnet" {
    name = var.db_subnet_name
    resource_group_name = var.resource_group_name
    virtual_network_name =   var.virtual_network_name
    address_prefixes = [ var.dbsubnet_address_space]
    depends_on = [
        azurerm_virtual_network.network
     ]
}

resource "azurerm_network_security_group" "nsg-web" {
     name = var.nsg_web_name
     location = var.location
     resource_group_name = var.resource_group_name
     depends_on = [ azurerm_virtual_network.network ]

     security_rule {
        name                       = "RDPrule"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
    security_rule {
        name                       = "httprule"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
  }

  security_rule {
        name                       = "vscrule"
        priority                   = 300
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "nsg-db" {
     name = var.nsg_db_name
     location = var.location
     resource_group_name = var.resource_group_name
     depends_on = [ azurerm_virtual_network.network ]

     security_rule {
        name                       = "RDPrule"
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

resource "azurerm_subnet_network_security_group_association" "nsgtowebsubnet" {
  subnet_id                 = azurerm_subnet.appsubnet.id
  network_security_group_id = azurerm_network_security_group.nsg-web.id
  depends_on = [ azurerm_virtual_network.network,azurerm_network_security_group.nsg-web ]
}

resource "azurerm_subnet_network_security_group_association" "nsgtodbsubnet" {
  subnet_id                 = azurerm_subnet.dbsubnet.id
  network_security_group_id = azurerm_network_security_group.nsg-db.id
  depends_on = [ azurerm_virtual_network.network,azurerm_network_security_group.nsg-db ]
}
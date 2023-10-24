output "network" {
  value = azurerm_virtual_network.network
}

output "appsubnet" {
  value = azurerm_subnet.appsubnet
}

output "dbsubnet" {
  value = azurerm_subnet.dbsubnet
}
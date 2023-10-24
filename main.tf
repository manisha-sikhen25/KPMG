module "general_module" {
    source="./modules/general"
    resource_group_name = local.resource_group_name
    location = local.location
}

module "networking_module" {
source = "./modules/Networking"
resource_group_name = local.resource_group_name
location = local.location
virtual_network_name = local.virtual_network_name
virtual_address_space = local.virtual_address_space
app_subnet_name = local.app_subnet_name
appsubnet_address_space = local.appsubnet_address_space
db_subnet_name = local.db_subnet_name
dbsubnet_address_space =  local.dbsubnet_address_space
nsg_web_name = local.nsg_web_name
nsg_db_name = local.nsg_db_name

}

module "compute_module" {
  source = "./modules/compute"
  resource_group_name = local.resource_group_name
  location = local.location
  nic2 = local.nic2
  dbsubnet_id = module.networking_module.dbsubnet.id
  websubnet_id = module.networking_module.appsubnet.id
  dbpublic_ip_name = local.dbpublic_ip_name
  dbvm_name = local.dbvm_name
  admin_username = local.admin_username
  admin_password = local.admin_password
  webvm_name = local.webvm_name
  webpublic_ip_name = local.webpublic_ip_name
  depends_on = [ module.networking_module ]
  nic1 = local.nic1
  

}

resource "azurerm_mssql_virtual_machine" "mssqlmachine" {
  virtual_machine_id = module.compute_module.dbvm.id
  sql_license_type                 = "PAYG"
  r_services_enabled               = true
  sql_connectivity_port            = 1433
  sql_connectivity_type            = "PRIVATE"
  sql_connectivity_update_password = "Mother&)25071987"
  sql_connectivity_update_username = "adminlab"
}
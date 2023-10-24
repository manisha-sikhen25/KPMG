locals {
  resource_group_name = "LabRG"
  location = "eastus2"
  virtual_network_name = "labvnet"
  virtual_address_space = "10.0.0.0/16"
  app_subnet_name = "websubnet"
  appsubnet_address_space = "10.0.0.0/24" 
  db_subnet_name = "dbsubnet"
  dbsubnet_address_space = "10.0.1.0/24"
  nsg_web_name = "web-nsg"
  nsg_db_name = "db-nsg"
  nic2 = "db-nic"
  nic1 = "web-nic"
  #admin_username = "adminlab"
  #admin_password = "Mother&)25071987"
  dbvm_name = "dbtier"
  dbpublic_ip_name = "db_ip"
  webvm_name = "webtier"
  webpublic_ip_name = "web_ip"
  kvname = "kv10000"

}


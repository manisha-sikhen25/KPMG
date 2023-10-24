variable "resource_group_name" {

    type = string
    description = "this is the name of the respurce group"
}

variable "location" {

    type = string
    description = "name of the location"
}

variable "virtual_network_name" {
    type = string
    description = "name of the virtual network"
}

variable "virtual_address_space" {
    type = string
    description = "address space of the virtual network"
}

variable "app_subnet_name" {
    type = string
    description = "name of the subnet"
}

variable "appsubnet_address_space" {
    type = string
    description = "address space of the app subnet network"
}

variable "db_subnet_name" {
    type = string
    description = "name of the db subnet"
}

variable "dbsubnet_address_space" {
    type = string
    description = "address space of the subnet  network"
}

variable "nsg_web_name" {
    type = string
    description = "name of the web subnet nsg"
}

variable "nsg_db_name" {
    type = string
    description = "name of the db subnet nsg"
}
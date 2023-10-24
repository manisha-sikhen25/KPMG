variable "resource_group_name" {

    type = string
    description = "this is the name of the respurce group"
}

variable "location" {

    type = string
    description = "name of the location"
}

variable "nic1" {
    type = string
    description = "name of the web interface"
}

variable "nic2" {
    type = string
    description = "name of the db interface"
}

variable "websubnet_id" {
    type =string
    description = "id of the web subnet"
}

variable "dbsubnet_id" {
    type =string
    description = "id of the db subnet"
}

variable "webpublic_ip_name" {
    type =string
    description = "name of the web public IP"
}

variable "dbpublic_ip_name" {
    type =string
    description = "name of the db public IP"
}

variable "webvm_name" {
    type =string
    description = "name of the web vm"
}

variable "dbvm_name" {
    type =string
    description = "name of the db vm"
}

variable "admin_username" {
    type = string
    description = "admin usernmae for db vm"
  
}
variable "admin_password" {
    type = string
    description = "admin password for db vm"
  
}
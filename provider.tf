terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}


provider "azurerm" {
  subscription_id = "8966054e-db4c-451b-bc06-1d31df5681fc"
  tenant_id = "f36fbb12-b119-489e-b9cf-794f5bea7473"
  client_id = "068622bd-9e56-468b-be6e-6e1ac6fc4904"
  client_secret = "Ecl8Q~OFVK-eDIWYyvu4BGmlNsnyeQUdoibL2bQ8"
  features {}
}

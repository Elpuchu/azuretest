# Creación de la red
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network

resource "azurerm_virtual_network" "aztestNet" {
    name                = "kubernetesnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.aztrg.location
    resource_group_name = azurerm_resource_group.aztrg.name

    tags = {
        environment = "azurestest"
    }
}

# Creación de la subnet
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet

resource "azurerm_subnet" "aztestSubnet" {
    name                   = "terraformsubnet"
    resource_group_name    = azurerm_resource_group.aztrg.name
    virtual_network_name   = azurerm_virtual_network.aztestNet.name
    address_prefixes       = ["10.0.1.0/24"]

}

# Creación de la NIC
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "aztestNic" { 
  name                = "nic-${var.vms[count.index]}" #var.vms : lista de vm definidos en vars.tf
  count               = length(var.vms)  
  location            = azurerm_resource_group.aztrg.location
  resource_group_name = azurerm_resource_group.aztrg.name

    ip_configuration {
        name                           = "ipcfg-${var.vms[count.index]}"
        subnet_id                      = azurerm_subnet.aztestSubnet.id 
        private_ip_address_allocation  = "Static"
        private_ip_address             = "10.0.1.${count.index + 10}"
        public_ip_address_id           = azurerm_public_ip.aztPublicIp[count.index].id
    }

    tags = {
        environment = "azurestest"
    }

}

# Creación de la IP pública
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "aztPublicIp" {
  name                = "ipp-${var.vms[count.index]}" #var.vms : lista de vm definidos en vars.tf
  count               = length(var.vms) 
  location            = azurerm_resource_group.aztrg.location
  resource_group_name = azurerm_resource_group.aztrg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = "azurestest"
    }

}

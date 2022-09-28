resource "azurerm_resource_group" "rg" {
  name     = var.rgName
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnetName
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.addressSpace
  dns_servers         = []
}

resource "azurerm_subnet" "subnet" {
  for_each             = { for subnet in var.subnetsToCreate : subnet.name => subnet }
  name                 = each.value.name
  address_prefixes     = ["${each.value.addressPrefix}"]
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name

}

resource "azurerm_network_security_group" "nsg" {
  for_each            = azurerm_subnet.subnet
  name                = "nsg-${each.value.name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "association" {
  for_each                  = { for subnet in var.subnetsToCreate : subnet.name => subnet }
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}

# resource "azurerm_network_security_group" "nsg" {
#   for_each            = { for subnet in var.subnetsToCreate : subnet.name => subnet }
#   name                = "nsg-${each.value.name}"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
# }

# resource "azurerm_subnet_network_security_group_association" "association" {
#   for_each                  = { for subnet in var.subnetsToCreate : subnet.name => subnet }
#   subnet_id                 = azurerm_subnet.subnet[each.key].id
#   network_security_group_id = azurerm_network_security_group.nsg[each.key].id
# }

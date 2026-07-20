resource "azurerm_network_security_group" "nsg" {
    for_each = var.nsgs
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  security_rule {
    name                       = "nsg1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "80"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  for_each = var.nsgs

  subnet_id                 = var.subnet_ids[each.value.subnet_key]
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}

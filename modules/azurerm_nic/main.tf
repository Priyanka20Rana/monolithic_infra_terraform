resource "azurerm_network_interface" "nic" {
    for_each = var.nics
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
   subnet_id = var.subnet_ids[each.value.nic_configuration.subnet_key]
   public_ip_address_id = var.pip_ids[each.value.nic_configuration.pip_key]
    private_ip_address_allocation = "Dynamic"
  }
}

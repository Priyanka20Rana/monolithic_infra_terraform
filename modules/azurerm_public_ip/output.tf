output "pip_ids" {
  description = "Map of pip IDs"

  value = {
    for key, pip in azurerm_public_ip.pip :
    key => pip.id
  }
}
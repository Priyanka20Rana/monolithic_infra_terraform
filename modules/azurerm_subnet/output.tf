output "subnet_ids" {
  description = "Map of subnet IDs"

  value = {
    for key, subnet in azurerm_subnet.trial-subnet :
    key => subnet.id
  }
}
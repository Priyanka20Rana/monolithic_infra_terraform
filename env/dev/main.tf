module "rg-module" {
  source          = "../../modules/azurerm_resource_group"
  resource_groups = var.rgs

}
module "vnet-module" {
  source     = "../../modules/azurerm_virtual_network"
  vnets      = var.virtual_networks
  depends_on = [module.rg-module]
}
module "subnet-module" {
  source     = "../../modules/azurerm_subnet"
  subnets    = var.subnets
  depends_on = [module.vnet-module]

}
module "nic" {
  source     = "../../modules/azurerm_nic"
  nics       = var.nic
  subnet_ids = module.subnet-module.subnet_ids
  depends_on = [module.subnet-module]

}
module "virtual_machine" {
  source     = "../../modules/azure_virtual_machine"
  vms        = var.vm
  nic_ids    = module.nic.nic_ids
  depends_on = [module.nic]
}
module "database" {
  source              = "../../modules/azurerm_database"
  db_server_name      = var.db_server_name
  db                  = var.db
  resource_group_name = var.resource_group_name
  location            = var.location

}
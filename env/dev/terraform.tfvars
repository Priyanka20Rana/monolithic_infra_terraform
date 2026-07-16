rgs = {
  rg1 = {
    name     = "dev-rg"
    location = "central india"
  }

}

virtual_networks = {
  vnet1 = {
    name                = "frontend-vnet"
    resource_group_name = "dev-rg"
    location            = "central india"
    address_space       = ["10.0.0.0/16"]
  }
  vnet2 = {
    name                = "backend-vnet"
    resource_group_name = "dev-rg"
    location            = "central india"
    address_space       = ["10.1.0.0/16"]
  }
}

subnets = {
  subnet1 = {
    name                 = "frontend-subnet"
    resource_group_name  = "dev-rg"
    virtual_network_name = "frontend-vnet"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet2 = {
    name                 = "backend-subnet"
    resource_group_name  = "dev-rg"
    virtual_network_name = "backend-vnet"
    address_prefixes     = ["10.1.1.0/24"]
  }
}
nic = {
  nic1 = {
    name                = "frontend-nic"
    resource_group_name = "dev-rg"
    location            = "central india"
    nic_configuration = {

      subnet_key = "subnet1"

    }
  }
  nic2 = {
    name                = "backend-nic"
    resource_group_name = "dev-rg"
    location            = "central india"
    nic_configuration = {

      subnet_key = "subnet2"

    }

  }
}

vm = {
  vm1 = {
    name                  = "frontend-vm"
    resource_group_name   = "dev-rg"
    location              = "central india"
    size                  = "Standard_D2s_v3"
    network_interface_ids = ["nic1"]
    nic_key               = "nic1"
  }
  vm2 = {
    name                  = "backend-vm"
    resource_group_name   = "dev-rg"
    location              = "central india"
    size                  = "Standard_D2s_v3"
    network_interface_ids = ["nic2"]
    nic_key               = "nic2"
  }
}
db_server_name      = "monolithic-db-server"
db                  = "monolithic-db"
resource_group_name = "dev-rg"
location            = "central india"
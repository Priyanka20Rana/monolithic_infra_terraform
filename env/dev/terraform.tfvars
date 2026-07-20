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
      pip_key    = "pip1"

    }
  }
  nic2 = {
    name                = "backend-nic"
    resource_group_name = "dev-rg"
    location            = "central india"
    nic_configuration = {

      subnet_key = "subnet2"
      pip_key    = "pip2"

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
# db_server_name      = "monolithic-db-server"
# db                  = "monolithic-db"
# resource_group_name = "dev-rg"
# location            = "central india"
db_sql_server = {

  server1 = {
    name                = "dev-sql-server-32"
    resource_group_name = "dev-rg"
    location            = "Central India"
  }

  server2 = {
    name                = "prod-sql-server-23"
    resource_group_name = "dev-rg"
    location            = "Central India"
  }

}

sql_db_mono = {

  db1 = {
    name          = "EmployeeDB"
    db_server_key = "server1"
  }

  db2 = {
    name          = "SalesDB"
    db_server_key = "server2"
  }

}
pips = {
  pip1 = {
    name                = "frontend-pip"
    resource_group_name = "dev-rg"
    location            = "central india"
  }
  pip2 = {
    name                = "backend-pip"
    resource_group_name = "dev-rg"
    location            = "central india"
  }

}
nsgs = {
  nsg1 = {
    name = "frontend-nsg"
    location = "central india"
     resource_group_name  = "dev-rg"
      subnet_key          = "subnet1"
  }
  nsg2 = {
    name = "backend-nsg"
    location = "central india"
     resource_group_name  = "dev-rg"
      subnet_key          = "subnet2"
  }
}


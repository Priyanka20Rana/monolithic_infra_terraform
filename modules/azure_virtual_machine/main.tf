data "azurerm_key_vault" "kv" {
  name                = "vm-kv070290"
  resource_group_name = "kv_rg"
}

data "azurerm_key_vault_secret" "vm_username" {
  name         = "vm-username"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "vm_password" {
  name         = "vm-password"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_linux_virtual_machine" "vm" {
    for_each = var.vms
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
 admin_username = data.azurerm_key_vault_secret.vm_username.value
  network_interface_ids = [var.nic_ids[each.value.nic_key]]

admin_password = data.azurerm_key_vault_secret.vm_password.value
 disable_password_authentication = "false"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  # Connection Block

  connection {
  type     = "ssh"
  user     = data.azurerm_key_vault_secret.vm_username.value
  password = data.azurerm_key_vault_secret.vm_password.value
  host     = self.public_ip_address
  timeout  = "10m"
}

   # 1. FILE Provisioner
provisioner "file" {
  source      = "${path.module}/script.sh"
  destination = "/tmp/script.sh"
}

provisioner "file" {
  source      = "${path.module}/index.html"
  destination = "/tmp/index.html"
}
   
  # 2. REMOTE-EXEC Provisioner
 provisioner "remote-exec" {
  inline = [
    "chmod +x /tmp/script.sh",
    "sudo bash /tmp/script.sh"
  ]
}

  ###################################################
  # 3. LOCAL-EXEC Provisioner
  ###################################################
  provisioner "local-exec" {
    command = "echo VM ${self.name} created successfully >> vm_details.txt"
  }
}

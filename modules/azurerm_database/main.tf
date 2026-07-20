# resource "azurerm_mssql_server" "db-server" {
#   name                         = var.db_server_name
#   resource_group_name          = var.resource_group_name
#   location                     = var.location
#   version                      = "12.0"
#   administrator_login          = "4dm1n157r470r"
#   administrator_login_password = "4-v3ry-53cr37-p455w0rd"
# }

# resource "azurerm_mssql_database" "sql_db" {
#   name         = var.db
#   server_id    = azurerm_mssql_server.db-server.id
#   collation    = "SQL_Latin1_General_CP1_CI_AS"
#   license_type = "LicenseIncluded"
#   max_size_gb  = 2
#   sku_name     = "S0"
#   enclave_type = "VBS"

#   tags = {
#     foo = "bar"
#   }
# }
resource "azurerm_mssql_server" "db-server" {
    for_each = var.db_sql_server
  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azurerm_mssql_database" "sql_db" {
    for_each = var.sql_db_mono
  name         = each.value.name
  server_id = azurerm_mssql_server.db-server[each.value.db_server_key].id
  sku_name     = "S0"
}
 
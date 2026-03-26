resource "azurerm_postgresql_flexible_server" "db" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  zone                = "2"

  administrator_login    = var.admin_user
  administrator_password = var.admin_password

  sku_name  = "B_Standard_B1ms"
  version   = "15"

  public_network_access_enabled = false
}
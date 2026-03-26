resource "azurerm_postgresql_flexible_server" "db" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  zone                = "2"

  administrator_login    = var.admin_user
  administrator_password = var.admin_password

  sku_name  = "B_Standard_B1ms"
  version   = "15"

  public_network_access_enabled = var.network_access
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "public_ip" {
  for_each = toset(var.allowed_public_ips)

  name                = "allow-${replace(each.value, ".", "-")}"
  server_id           = azurerm_postgresql_flexible_server.db.id
  start_ip_address    = each.value
  end_ip_address      = each.value
}

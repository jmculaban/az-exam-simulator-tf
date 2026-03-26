resource "azurerm_private_endpoint" "pe" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.name}-connection"
    private_connection_resource_id = var.resource_id
    subresource_names              = var.subresource_names
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                  = "default"
    private_dns_zone_ids  = var.private_dns_zone_ids
  }
}
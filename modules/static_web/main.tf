resource "azurerm_static_web_app" "frontend" {
  name                  = var.name
  resource_group_name   = var.rg_name
  location              = var.location

  sku_tier = "Free"
  sku_size = "Free"
}
resource "azurerm_service_plan" "plan" {
  name                  = var.plan_name
  location              = var.location
  resource_group_name   = var.rg_name
  os_type               = "Linux"
  sku_name              = "B1"
}

resource "azurerm_linux_web_app" "app" {
  name                  = var.app_name
  location              = var.location
  resource_group_name   = var.rg_name
  service_plan_id       = azurerm_service_plan.plan.id

  https_only = true

  site_config {
    ftps_state          = "Disabled"
    minimum_tls_version = "1.2"
  }
}
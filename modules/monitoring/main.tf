resource "azurerm_application_insights" "appi" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  application_type    = "web"
}
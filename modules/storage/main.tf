resource "azurerm_storage_account" "storage" {
  name                      = var.name
  resource_group_name       = var.rg_name
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  
  public_network_access_enabled = false

  https_traffic_only_enabled = true
  min_tls_version = "TLS1_2"
}
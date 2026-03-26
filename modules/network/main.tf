resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  address_space       = var.vnet_address_space
}

# Subnet for app service
resource "azurerm_subnet" "app_service" {
  name                 = "snet-app-service"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.as_subnet_address_prefixes

  delegation {
    name = "delegation"

    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

# Subnet for private endpoints
resource "azurerm_subnet" "private_endpoints" {
  name                 = "snet-private-endpoints"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.pe_subnet_address_prefixes

  private_endpoint_network_policies = "Disabled"
}

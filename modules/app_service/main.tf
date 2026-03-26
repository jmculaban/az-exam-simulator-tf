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

    application_stack {
      docker_image_name   = var.docker_image_name
      docker_registry_url = var.docker_registry_url
    }
  }

  app_settings = {
    WEBSITES_PORT = "8080"

    WEBSITE_DNS_SERVER = "168.63.129.16"

    DOCKER_REGISTRY_SERVER_URL      = var.docker_registry_url
    DOCKER_REGISTRY_SERVER_USERNAME = var.docker_username
    DOCKER_REGISTRY_SERVER_PASSWORD = var.docker_password

    SPRING_DATASOURCE_URL      = var.db_url
    SPRING_DATASOURCE_USERNAME = var.db_username
    SPRING_DATASOURCE_PASSWORD = var.db_password

    SPRING_FLYWAY_ENABLED = "true"
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_integration" {
  app_service_id = azurerm_linux_web_app.app.id
  subnet_id = var.app_service_subnet_id
}
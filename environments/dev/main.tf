provider "azurerm" {
  features {}
}
module "rg" {
  source    = "../../modules/resource_group"
  name      = local.rg_name
  location  = "Southeast Asia"
}

module "app_service" {
  source    = "../../modules/app_service"
  plan_name = local.plan_name
  app_name  = local.app_name
  rg_name   = module.rg.name
  location  = module.rg.location

  docker_image_name = "${module.acr.login_server}/azexam-backend:v1"
  docker_registry_url = "https://${module.acr.login_server}"
  docker_username = module.acr.admin_username
  docker_password = module.acr.admin_password

  db_url = "jdbc:postgresql://${module.postgres.fqdn}:5432/postgres"
  db_username = var.db_username
  db_password = var.db_password
}

module "frontend" {
  source    = "../../modules/static_web"
  name      = local.frontend_name
  rg_name   = module.rg.name
}

module "storage" {
  source    = "../../modules/storage"
  name      = local.storage_name
  rg_name   = module.rg.name
  location  = module.rg.location
}

module "postgres" {
  source          = "../../modules/postgres"
  name            = local.postgres_name
  rg_name         = module.rg.name
  location        = module.rg.location
  admin_user      = var.db_username
  admin_password  = var.db_password
  network_access  = true
  allowed_public_ips = var.postgres_allowed_public_ips
}

module "monitoring" {
  source    = "../../modules/monitoring"
  name      = local.appi_name
  rg_name   = module.rg.name
  location  = module.rg.location
}

module "network" {
  source    = "../../modules/network"
  name      = local.vnet_name
  rg_name   = module.rg.name
  location  = module.rg.location
}

module "private_dns" {
  source    = "../../modules/private_dns"
  rg_name   = module.rg.name
  vnet_id   = module.network.vnet_id
  vnet_name = local.vnet_name
}

module "postgres_pe" {
  source               = "../../modules/private_endpoint"
  name                 = "pe-postgres"
  location             = module.rg.location
  rg_name              = module.rg.name
  subnet_id            = module.network.private_endpoint_subnet_id
  resource_id          = module.postgres.id
  subresource_names    = ["postgresqlServer"]
  private_dns_zone_ids = [module.private_dns.postgres_zone_id]
}

module "storage_pe" {
  source               = "../../modules/private_endpoint"
  name                 = "pe-storage"
  location             = module.rg.location
  rg_name              = module.rg.name
  subnet_id            = module.network.private_endpoint_subnet_id
  resource_id          = module.storage.id
  subresource_names    = ["blob"]
  private_dns_zone_ids = [module.private_dns.blob_zone_id]
}

module "acr" {
  source = "../../modules/acr"
  name   = local.acr_name
  rg_name = module.rg.name
  location = module.rg.location
}
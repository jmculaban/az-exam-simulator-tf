locals {
  project = "azexam"
  env     = "dev"

  rg_name       = "rg-${local.project}-simulator-${local.env}"
  app_name      = "app-${local.project}-api-${local.env}"
  plan_name     = "asp-${local.project}-${local.env}"
  frontend_name = "stapp-${local.project}-frontend-${local.env}"
  postgres_name = "psql-${local.project}-${local.env}"
  appi_name     = "appi-${local.project}-${local.env}"
  vnet_name     = "vnet-${local.project}-${local.env}"
  acr_name      = "acr${local.project}${local.env}"

  # Storage must be globally unique, lowercase, no dashes
  storage_name  = lower("st${local.project}simulator${local.env}")
}
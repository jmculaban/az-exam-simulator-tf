output "resource_group" {
  value = module.rg.name
}

output "backend_url" {
  value = module.app_service.hostname
}

output "frontend_hostname" {
  value = module.frontend.default_hostname
}

output "storage_account" {
  value = module.storage.name
}

output "postgres_fqdn" {
  value = module.postgres.fqdn
}
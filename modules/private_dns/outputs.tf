output "postgres_zone_id" {
  value = azurerm_private_dns_zone.postgres.id
}

output "blob_zone_id" {
  value = azurerm_private_dns_zone.blob.id
}
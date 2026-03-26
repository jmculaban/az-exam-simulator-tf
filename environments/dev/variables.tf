variable "db_username" {
  type        = string
}

variable "db_password" {
  type        = string
  sensitive   = true
}

variable "postgres_allowed_public_ips" {
  description = "Temporary list of public IPv4 addresses allowed to connect to PostgreSQL in dev."
  type        = list(string)
  default     = []
}
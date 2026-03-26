variable "name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "admin_user" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "network_access" {
  type    = bool
  default = false
}

variable "allowed_public_ips" {
  description = "Public IPv4 addresses allowed to connect to PostgreSQL. Each IP creates a single-IP firewall rule."
  type        = list(string)
  default     = []
}
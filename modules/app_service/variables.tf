variable "plan_name" {
  type = string
}

variable "app_name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "docker_image_name" {
  type = string
}

variable "docker_registry_url" {
  type = string
}

variable "docker_username" {
  type = string
}

variable "docker_password" {
  type      = string
  sensitive = true
}

variable "db_url" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}
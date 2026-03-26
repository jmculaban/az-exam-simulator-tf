variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the VNet"
  default     = ["10.0.0.0/16"]
}

variable "pe_subnet_address_prefixes" {
  type        = list(string)
  description = "Address prefixes for the private endpoints subnet"
  default     = ["10.0.1.0/24"]
}

variable "as_subnet_address_prefixes" {
  type        = list(string)
  description = "Address prefixes for the app service subnet"
  default     = ["10.0.2.0/24"]
}
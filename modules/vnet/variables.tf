variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Virtual Network"
  type        = string
}

variable "address_space" {
  description = "The address space that is used by the Virtual Network"
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

variable "subnet_names" {
  description = "A list of subnet names to create within the Virtual Network"
  type        = list(string)
}

variable "subnet_prefixes" {
  description = "A list of subnet address prefixes corresponding to the subnet names"
  type        = list(string)
}
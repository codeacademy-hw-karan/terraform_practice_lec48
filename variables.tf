# variables.tf
variable "location" {
  description = "The Azure location to deploy the resources"
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "terraform-resource-group"
}

variable "vm_size" {
  description = "The VM size"
  type        = string
  default     = "Standard_B1s"
  validation {
    condition = contains(["Standard_B1s", "Standard_B2s", "Standard_D2s_v3"], var.vm_size)
    error_message = "vm_size must be one of 'Standard_B1s', 'Standard_B2s', or 'Standard_D2s_v3'."
  }
}

variable "admin_username" {
  description = "Admin username for the VMs"
  type        = string
}

variable public_key {
  type        = string
  default     = ""
  description = "Public key for new VMs"
}

variable "environment" {
  description = "The environment for the deployment"
  type        = string
  default     = "dev"
}

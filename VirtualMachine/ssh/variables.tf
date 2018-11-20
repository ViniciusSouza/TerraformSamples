variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
  default     = "viniteste"
}

variable "public_ip_dns" {
  description = "Optional globally unique per datacenter region domain name label to apply to each public ip address. e.g. thisvar.varlocation.cloudapp.azure.com where you specify only thisvar here. This is an array of names which will pair up sequentially to the number of public ips defined in var.nb_public_ip. One name or empty string is required for every public ip. If no public ip is desired, then set this to an array with a single empty string."
  default     = [""]
}

variable "vm_name" {
  description = "The name of virtual machine that will be created"
  default     = "vinitest"
}

variable "vm_hostname" {
  description = "Name of the host"
  default     = "vinitest"
}

variable "custom_image_id" {
  description = "id of the image"
  default     = "/subscriptions/subscription_id/resourceGroups/resource_name/providers/Microsoft.Compute/images/image_name"
}

variable "username" {
  description = "username name"
  default     = "visouza"
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  default     = "Standard_DS2"
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "eastus"
}

variable "vnet_name" {
  description = "Virtual Network Name"
  default     = "vnetsample"
}

variable "vnet_address_space" {
  description = "Virtual Network Address Space"
  default     = "10.0.0.0/16"
}

variable "subnet_name" {
  description = "Virtual Subnet Network Name"
  default     = "mysubnet"
}

variable "subnet_address_space" {
  description = "Subnet Network Address Space"
  default     = "10.0.0.0/24"
}

variable "environment_tag" {
  description = "Tag for resources"
  default     = "testing"
}

variable "subscription_id" {
  description = "The subscription that will be used to create the resources"
  default = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}

variable "client_id" {
  description = "Client Id for the service principal"
  default = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}

variable "client_secret" {
  description = "Client Secret for the service principal"
  default = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}

variable "tenant_id" {
  description = "Tennant Id where the service principal was created"
  default = "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}

variable "key_vault_name" {
  description = "key vault name used to store data"
  default = ""
}

variable "key_vault_resource_group" {
  description = "Resource Group where the key vault is provissioned"
  default = ""
}

variable "key_vault_keyname" {
  description = "key name used at the key vault"
  default = ""
}

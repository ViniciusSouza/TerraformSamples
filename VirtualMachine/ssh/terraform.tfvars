resource_group_name     = "viniteste"
location                = "eastus"
vm_name                 = "MyTestVM"
username                = "visouza"
vm_hostname             = "myvmvinitest"
vm_size                 = "Standard_DS2"
public_ip_dns           = ["myvmgpu"]
vnet_name               = "vnetsample"
vnet_address_space      = "10.0.0.0/16"
subnet_name             = "mysubnet" 
subnet_address_space    = "10.0.0.0/24"
environment_tag         = "testing"
key_vault_resource_group = "VS-CSEEEVstsTracker-Group"
key_vault_name          = "testeeee"
key_vault_keyname       = "sshvm"
# TerraformSamples
Some terraform samples that can be usefull


## 1) SSH
   Create a linux virtual machine using a Azure Key Vault for SSH.

   ### Pre-requisites:
   1) Service principal to run the script, with Contributor role, check the [Terraform ocumentation](https://www.terraform.io/docs/providers/azurerm/authenticating_via_service_principal.html)
   2) Secret created on Azure Key Vault, check this [documentation](https://docs.microsoft.com/en-us/azure/key-vault/quick-create-portal)
   
   ### Variables
    List of variables used and its propose
    
   ```
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
 ```
# TerraformSamples
Some terraform samples that can be usefull


## 1) SSH
   Create a linux virtual machine using a Azure Key Vault for SSH.

   ### Pre-requisites:
   1) Service principal to run the script, with Contributor role, check the [Terraform documentation](https://www.terraform.io/docs/providers/azurerm/authenticating_via_service_principal.html)
   2) Secret created on Azure Key Vault, check this [Azure documentation](https://docs.microsoft.com/en-us/azure/key-vault/quick-create-portal)
   3) Be sure that the Service Principal used by the terraform script has the proper rights.

   ### Variables
   List of variables used and its propose

   ```
   resource_group_name       # Name of the resource group where the resources will be created.
   location                  # Azure region for resources provision
   vm_name                   # Azure Virtual Machine name (resource name)
   username                  # VM user name
   vm_hostname               # Name of the host used by the virtual machine
   vm_size                   # Azure VM Size, check [Azure VMs](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/sizes)
   public_ip_dns             # Azure domain name for the region
   vnet_name                 # Name of the Virtual network
   vnet_address_space        # VNET address space
   subnet_name               # Subnet name
   subnet_address_space      # Subnet address space
   environment_tag           # Resources Tagi
   key_vault_resource_group  # Name of the resource group where the Key Vault belong to.
   key_vault_name            # Key vault name
   key_vault_keyname         # Secret key name
 ```
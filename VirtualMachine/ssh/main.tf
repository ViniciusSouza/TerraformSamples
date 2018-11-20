# Configure the Microsoft Azure Provider
provider "azurerm" {
    subscription_id = "${var.subscription_id}"
    client_id       = "${var.client_id}"
    client_secret   = "${var.client_secret}"
    tenant_id       = "${var.tenant_id}"
}

data "azurerm_client_config" "current" {}


# Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "resourcegroup" {
    name     = "${var.resource_group_name}"
    location = "${var.location}"

    tags {
        environment = "${var.environment_tag}"
    }
}

data "azurerm_key_vault" "keyvault" {
  name                = "${var.key_vault_name}"
  resource_group_name = "${var.key_vault_resource_group}"
}

data "azurerm_key_vault_secret" "vmsecret" {
  name      = "${var.key_vault_keyname}"
  vault_uri = "${data.azurerm_key_vault.keyvault.vault_uri}"
}

# Create virtual network
resource "azurerm_virtual_network" "network" {
    name                = "${var.vnet_name}"
    address_space       = ["${var.vnet_address_space}"]
    location            = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name = "${azurerm_resource_group.resourcegroup.name}"

    tags {
        environment = "${var.environment_tag}"
    }
}

# Create subnet
resource "azurerm_subnet" "subnet" {
    name                 = "${var.subnet_name}"
    resource_group_name  = "${azurerm_resource_group.resourcegroup.name}"
    virtual_network_name = "${azurerm_virtual_network.network.name}"
    address_prefix       = "${var.subnet_address_space}"
}

# Create public IPs
resource "azurerm_public_ip" "publicip" {
    name                         = "${lower(var.vm_name)}pubip"
    location                     = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name          = "${azurerm_resource_group.resourcegroup.name}"
    public_ip_address_allocation = "dynamic"
    domain_name_label            = "${element(var.public_ip_dns, count.index)}"

    tags {
        environment = "${var.environment_tag}"
    }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg" {
    name                = "${lower(var.vm_name)}nsg"
    location            = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name = "${azurerm_resource_group.resourcegroup.name}"

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags {
        environment = "${var.environment_tag}"
    }
}

# Create network interface
resource "azurerm_network_interface" "nic" {
    name                      = "${lower(var.vm_name)}nic"
    location                  = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name       = "${azurerm_resource_group.resourcegroup.name}"
    network_security_group_id = "${azurerm_network_security_group.nsg.id}"

    ip_configuration {
        name                          = "${lower(var.vm_name)}nicconf"
        subnet_id                     = "${azurerm_subnet.subnet.id}"
        private_ip_address_allocation = "dynamic"
        public_ip_address_id          = "${azurerm_public_ip.publicip.id}"
    }

    tags {
        environment = "${var.environment_tag}"
    }
}

# Generate random text for a unique storage account name
resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = "${azurerm_resource_group.resourcegroup.name}"
    }

    byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "storage_diag" {
    name                        = "diag${random_id.randomId.hex}"
    resource_group_name         = "${azurerm_resource_group.resourcegroup.name}"
    location                    = "${azurerm_resource_group.resourcegroup.location}"
    account_tier                = "Standard"
    account_replication_type    = "LRS"

    tags {
        environment = "${var.location}"
    }
}

# Create virtual machine
resource "azurerm_virtual_machine" "vm" {
    name                  = "${var.vm_name}"
    location              = "${azurerm_resource_group.resourcegroup.location}"
    resource_group_name   = "${azurerm_resource_group.resourcegroup.name}"
    network_interface_ids = ["${azurerm_network_interface.nic.id}"]
    vm_size               = "${var.vm_size}"

    storage_os_disk {
        name              = "${lower(var.vm_name)}osdisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
    }

    ##Azure Image
    # storage_image_reference {
    #     publisher = "Canonical"
    #     offer     = "UbuntuServer"
    #     sku       = "16.04.0-LTS"
    #     version   = "latest"
    # }

    ##Custom Image
    storage_image_reference {
        id = "${var.custom_image_id}"
    }

    os_profile {
        computer_name  = "${lower(var.vm_hostname)}"
        admin_username = "${var.username}"
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path     = "/home/${var.username}/.ssh/authorized_keys"
            key_data = "${data.azurerm_key_vault_secret.vmsecret.value}"
        }
    }

    boot_diagnostics {
        enabled = "true"
        storage_uri = "${azurerm_storage_account.storage_diag.primary_blob_endpoint}"
    }

    tags {
        environment = "${var.environment_tag}"
    }
}
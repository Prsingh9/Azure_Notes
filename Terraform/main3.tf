#azure terraform script to create two VMs in parallel 

provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
}

#Resource Group
resource "azurerm_resource_group" "prab-rg01" {
  name     = "prab-rg01"
  location = "Central India"
}

#virtual network
resource "azurerm_virtual_network" "prab-vnet01" {
  name                = "prab-vnet01"
  location            = "Central India"
  resource_group_name = azurerm_resource_group.prab-rg01.name
  address_space       = ["10.33.0.0/16"]
}

#subnet
resource "azurerm_subnet" "prab-subnet" {
  name                 = "prab-subnet"
  resource_group_name  = azurerm_resource_group.prab-rg01.name
  virtual_network_name = azurerm_virtual_network.prab-vnet01.name
  address_prefixes     = ["10.33.0.0/24"]
}

#network interface
resource "azurerm_network_interface" "prab-nic" {
  name                = "prab-nic"
  location            = "Central India"
  resource_group_name = azurerm_resource_group.prab-rg01.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.prab-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

#network interface 2
#network interface
resource "azurerm_network_interface" "prab-nic02" {
  name                = "prab-nic02"
  location            = "Central India"
  resource_group_name = azurerm_resource_group.prab-rg01.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.prab-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

#virtual machine 1
resource "azurerm_linux_virtual_machine" "prab-linuxVM01" {
  name                = "prab-linuxVM01"
  resource_group_name = azurerm_resource_group.prab-rg01.name
  location            = "Central India"
  size                = "Standard_F2"
  admin_username      = "user18"
  network_interface_ids = [
    azurerm_network_interface.prab-nic.id
  ]

  admin_ssh_key {
    username   = "user18"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

#virtual machine 2
resource "azurerm_linux_virtual_machine" "prab-linuxVM02" {
  name                = "prab-linuxVM02"
  resource_group_name = azurerm_resource_group.prab-rg01.name
  location            = "Central India"
  size                = "Standard_F2"
  admin_username      = "user18"
  network_interface_ids = [
    azurerm_network_interface.prab-nic02.id
  ]

  admin_ssh_key {
    username   = "user18"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
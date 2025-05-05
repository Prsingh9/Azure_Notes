# terraform code to create scale set and attach load balancer to it 
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = ""
}

resource "azurerm_resource_group" "example" {
  name     = "prab-apache-rg"
  location = "Central India"
}

resource "azurerm_virtual_network" "example" {
  name                = "prab-apache-vnet"
  address_space       = ["10.34.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "public" {
  name                 = "prab-public-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.34.1.0/24"]
}

resource "azurerm_subnet" "private" {
  name                 = "prab-private-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.34.2.0/24"]
}

resource "azurerm_public_ip" "example" {
  name                = "prab-public-ip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  domain_name_label   = azurerm_resource_group.example.name

  tags = {
    environment = "staging"
  }
}

# NSG for VMSS Subnet
resource "azurerm_network_security_group" "web_nsg" {
  name                = "prabhakar-nsg"
  location            = resource.azurerm_resource_group.example.location
  resource_group_name = resource.azurerm_resource_group.example.name
 
  security_rule {
    name                       = "AllowHTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
 
resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
}
 

resource "azurerm_lb" "example" {
  name                = "prab-apache-LB"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  frontend_ip_configuration {
    name                 = "prab-PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

resource "azurerm_lb_backend_address_pool" "example" {
  name            = "prab-backend-pool"
  loadbalancer_id = azurerm_lb.example.id
}

# define health of azure lb
resource "azurerm_lb_probe" "example" {
  name                = "http-probe"
  loadbalancer_id     = azurerm_lb.example.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
}

resource "azurerm_lb_rule" "example" {
  name                           = "prab-http-rule"
 # resource_group_name            = azurerm_resource_group.example.name
  loadbalancer_id                = azurerm_lb.example.id
  frontend_ip_configuration_name = "prab-PublicIPAddress"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.example.id]
  probe_id                       = azurerm_lb_probe.example.id
}

resource "azurerm_lb_nat_pool" "example" {
  resource_group_name            = azurerm_resource_group.example.name
  name                           = "ssh-nat-pool"
  loadbalancer_id                = azurerm_lb.example.id
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50119
  backend_port                   = 22
  frontend_ip_configuration_name = "prab-PublicIPAddress"
  
}

resource "azurerm_linux_virtual_machine_scale_set" "example" {
  name                = "prab-apache-vmss"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  # SKU defined as arguments instead of a block
  sku   = "Standard_D2s_v3"
  instances  = 2

  # Image reference
  source_image_id =""

  # OS Disk
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # OS Profile

  admin_username = "user18"
  admin_ssh_key {
    public_key = file("/home/user18/prabhakar-VM_key.pub")
    username   = "user18"
  }

  # Network Interface
  network_interface {
    name    = "prab-apache-nic-profile"
    primary = true

    ip_configuration {
      name                                   = "TestIPConfiguration"
      primary                                = true
      subnet_id                              = azurerm_subnet.private.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.example.id]
      load_balancer_inbound_nat_rules_ids    = [azurerm_lb_nat_pool.example.id]
    }
  }

  # Health Probe
  health_probe_id = azurerm_lb_probe.example.id
  secure_boot_enabled = true

  tags = {
    environment = "prod"
  }
}

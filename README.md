**22-04-2025**


**PaaS** - Referred to platform as a service

## NFR - Non Functional Requirement ## 
- Refer to the characteristics of a software system that are not related to specific functionality or behavior. 
- They describe how the system should perform, rather than what it should do. 

**Example of NFR** 
- Performance 
- Availability and Reliability 
- Security 
- Scalability 
- Maintainability

- **Strategy** is a long term plan while **tactics** is short term plan to achieve a particular goal.

## SaaS - (Software as a Service)##

**Key characteristic**
- Web based access
- Centralized hosting 

**Benefits of SaaS**
- Lower upfront costs
- reduced IT overhead
- faster implementation 
- automatic updates and maintenance 
- scalability and flexibility 
- Accessibility 

## Deployment Model ##
- Public 
- Private 
- Hybrid

**Region**
- An Azure region consists of one or more datacenters, connected by a high-capacity, fault-tolerant, low-latency network connection. 
- Azure datacenters are typically located within a large metropolitan area.

**Availability zones**
- Many Azure regions provide availability zones.
- Availability zones are independent sets of datacenters that contain isolated power, cooling, and network connections.


## What is Azure Virtual Network? ##
- Azure Virtual Network is a service that provides the fundamental building block for your private network in Azure.

**Private IP Addressing:** VNets use private IP addresses for internal communication between resources, helping to ensure security.

**Communication Between Resources:** Resources within the same VNet can communicate with each other using their private IP addresses.

**Subnetting:** A VNet can be divided into multiple subnets to isolate different resources or to implement different levels of security.

**Peering:** VNets can be connected to other VNets within the same region or across regions using VNet Peering.

**VPN Gateways:** You can connect your VNet to on-premises networks through a VPN gateway or an ExpressRoute connection for hybrid cloud scenarios.

**Bastion host**
- A bastion host (also known as a jump host or jump server) is a special-purpose server used to provide secure access to private networks or internal infrastructure (like servers, databases, or internal web apps) from an external network (like the public internet). 
- It acts as a gatekeeper, allowing administrators or users to connect to internal systems without exposing those systems directly to the outside world.

**What Is a Bastion Host?**

- It's the only point of entry into a secured environment.

- All traffic to internal servers must pass through the bastion.

- It's placed in a public subnet (accessible via SSH or RDP), while the internal resources remain in a private subnet (not directly accessible from the internet).

**Scale set**
- In Azure, a scale set is a service that allows you to deploy and manage a group of identical, load-balanced virtual machines (VMs). 
- Scale sets enable you to automatically increase or decrease the number of VMs in response to demand or a defined schedule, providing high availability and scalability for your applications.

**Steps to connect to Azure VM**

1) Open the azure Cloud shell 

2) Change the permission of file to read-only using 
``` bash
chmod 400 key.pem
```


3) command to connect 
``` bash
ssh -i key.pem azureuser@<public_ip>

ssh -i prabhakar-vm01_key.pem azureuser@4.247.27.62
```

---

**23-04-2025**

# VNet and Subnetting Overview

## VNet Scope
- **Vnets are region scoped.**


## Subnetting

For example, let's consider the network `10.0.0.0/24`:

- **IP Range:** `10.0.0.0` to `10.0.0.255`

### Subnet Breakdown:

| N/W     | 1    | 2    | 4    | 8    | 16   | 32   | 64   | 128  | 256  |
|---------|------|------|------|------|------|------|------|------|------|
| HOST    | 256  | 128  | 64   | 32   | 16   | 8    | 4    | 2    | 1    |
| Subnet Mask | /24  | /25  | /26  | /27  | /28  | /29  | /30  | /31  | /32  |

**Calculation:**

- Total range: `32 - 24 = 8`  
- `2^8 = 256` total addresses.

### Subnetting Breakdown:

|           | IP Range      | Network ID  | Broadcast ID | Range      |
|--------------------|----------------|---------------|----------------| --------------|
| **First Range**     | `10.0.0.1 - 10.0.0.62` | `10.0.0.0`    | `10.0.0.63`    | `10.0.0.0/26`  |
| **Second Range**    | `10.0.0.65 - 10.0.0.126` | `10.0.0.64`   | `10.0.0.127`   | `10.0.0.64/26` |
| **Third Range**     | `10.0.0.129 - 10.0.0.190` | `10.0.0.128`  | `10.0.0.191`   | `10.0.0.128/26`|

---

**24-04-2025**

# Azure Essentials and Cloud Concepts


## Creating a New User in Azure

- Go to **Microsoft Entra ID** -> **Manage** -> **Users** -> **Create new User**


## Assigning Azure Role to a User or Group

Assign a predefined Azure role (like Owner, Contributor, Reader, etc.) to a user or group, giving them specific permissions to manage or access resources within the selected subscription.

- Go to: **Subscription** -> **MML** -> **Access Control (IAM)** -> **Add Role Assignment**


## Changing Quota

- **Quota** -> **Settings** -> **My Quota**  
- Click on resources for which we need to increase the quota -> **New Quota Request** -> **Enter a new limit** -> **Submit**

## Benefits of Public Cloud

- Cost efficiency  
- Scalability and flexibility  
- Global reach  
- Focus on core business  
- Sustainability

## Challenges of Public Cloud

- Security concerns  
- Vendor lock-in  

## Azure Global Infrastructure

- Availability Zones  
- Data Centers  
- Region Pairs  
- Azure Global Network

## Edge Location

In Microsoft Azure, an **Edge location** is a physical datacentre that's used to bring Azure services closer to end users for low latency and high performance.

## POP (Point of Presence)

**Point of Presence (POP)** is a network access point that allows data to enter or leave Azure's global network.

## Key Aspects of Cloud Regions

- Geographical Location  
- Multiple Data centers  
- Isolation

## ICMP - Internet Control Message Protocol

ICMP (Internet Control Message Protocol) does not use ports like TCP or UDP.  
Instead, ICMP is a protocol used for sending control messages in a network, such as error messages, echo requests (used in ping), and echo replies.


``` bash
az vm create \
 --resource-group <resource_group_name> \
 --name <vm_name> \
 --location <location> \
 --image <vm_image> \
 --vnet-name <vnet_name> \
 --subnet <subnet_name> \
 --admin-username <admin_username> \
 --admin-password <admin_password>
 ```
---

**25-04-2025**

**Tenants-** the highest level of the Azure hierarchy and represents an instance of Azure Active Directory (Azure AD). It’s your organization's identity directory and serves as the root for managing users, groups, and all identities within Azure.

**Management Groups-** A Management Group is a container that can hold multiple Azure subscriptions. It allows you to manage access, policies, and compliance across multiple subscriptions.

**Subscription** is a logical container that holds Azure resources. It’s tied to a billing account and defines the resources available for use.

**Resource Group** is a container that holds related Azure resources

**Resources** are the individual services


- Role is assigned to the identity 
- **identity**
	- Users
	- Groups
	- Service Principle (gives access to certain services)

- Scope is from Management Group to Resources .

**ACID**
**Atomicity -** ensures that a transaction is treated as a single, indivisible unit of work.
**Consistency -** ensures that a transaction takes the database from one consistent state to another consistent state.
**Isolation -** ensures that multiple transactions can execute concurrently without interfering with each other. 
**Durability -** ensures that once a transaction is committed, its changes are permanent and will survive any subsequent system failures.

## 🔐 Authentication & Account Management

```bash
az login                                 # Log in to Azure.
az --version                             # Display Azure CLI version.
az account list                          # List all Azure subscriptions.
az account list --output table           # List subscriptions in table format.
az account set --subscription "<subscription-id>"  # Set active subscription.
```

## ⚙️ Configuration Management

```bash
az config set defaults.location="East US 2"           # Set default location
az config set defaults.group="prab-RG"                # Set default resource group

az config get defaults                                # Get current default settings
az config get default                                 # Get default configuration setting

az show config                                        # Show full Azure CLI config
az show config get defaults                           # Get default config values
```


## 📦 Resource Group Management

```bash
az group create --name prab-RG --location "East US 2"           # Create a resource group

az group list                                                   # List all resource groups
az group list --query "[?location=='East US 2']"                # Filter groups by location
az group list --query "[?name=='prab-RG']"                      # Filter by name
az group list --query "[?name]"                                 # Show groups with name field
az group list --query "[].name" --output tsv                    # List group names in TSV format
az group list | grep "prab"                                     # Filter group list using grep
az group list --help                                            # Show help for 'az group list'
```

## 🖥️ Virtual Machine Management

```bash
az vm list                                                           # List all VMs
az vm list -g Admin-Azure                                            # List VMs in 'Admin-Azure' resource group
az vm list -g Admin-Azure --query "[].name" --output tsv             # List VM names (TSV format)
az vm list -g Admin-Azure --query "[].{Name:name}" --output tsv      # VM names with custom label
az vm list -g Admin-Azure --query "[].{Name:name,ResourceGroup:resourceGroup}" --output tsv
                                                                      # VM names and their resource groups

# Variants with grep
az vm list | grep -i name                                            # Filter all VMs for names using grep
az vm list -g Admin-Azure | grep -i name                             # Filter VMs in specific group using grep
```

## ☁️ Storage Management

```bash
az storage account list                     #List all storage accounts.

```
---

**26-04-2025**

# Managed Identities in Azure

Managed Identities in Azure are a way to securely authenticate your applications or services (like a runbook, virtual machine, or Azure app) to access other Azure resources without needing to store any credentials (like username/password or secrets).

## Two Types of Managed Identities:

### 1. System-assigned Managed Identity
- This identity is tied to the lifecycle of a specific Azure resource.
- When the resource is deleted, the managed identity is also automatically deleted.

### 2. User-assigned Managed Identity
- This identity is separate from the lifecycle of any specific resource.
- It can be assigned to multiple resources and managed independently.

---

**27-04-2025**

## IaC - Infrastructure as Code

Infrastructure as Code (IaC) is used for managing and provisioning computing infrastructure through machine-readable definition files, rather than physical hardware configuration or interactive configuration tools.

## Benefits of IaC

- **Consistency**
- **Speed**
- **Automation**
- **Reusability**
- **Scalability**
- **Version Control**


## Three Forms of IaC

### 1. Configuration Management Tools
- **Puppet**
- **Chef**
- **Ansible**

### 2. Server Templating
- **Vagrant**
- **Docker**

### 3. Infrastructure Provisioning Tools
- **Azure** (ARM Template, BICEP)
- **Terraform** (Multi-cloud)
- **AWS** (Boto, CloudFormation)


## HashiCorp Configuration Language (HCL)

- **HCL** is the configuration language used in Terraform to define infrastructure as code.


## Terraform Folder Structure

- **.terraform folder**: Contains all modules associated with the provider.
- **The lock file (.terraform.lock.hcl)**: Ensures that the exact versions of providers used in your Terraform configuration are locked down and consistent across different environments and machines.


## Terraform Commands

### `terraform plan`
- The `terraform plan` command is used to create an execution plan, which shows what actions Terraform will take to change your infrastructure based on the current state and the desired state defined in your Terraform configuration files.

    - `+` A resource will be created.
    - `-` A resource will be destroyed.
    - `~` A resource will be modified (updated).

### Use `-out` Flag to Save the Plan:
You can save the plan to a file and apply it later:
```bash
terraform plan -out=tfplan
terraform apply tfplan
```

---

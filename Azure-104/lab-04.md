# Manage Azure resources by using Azure Resource Manager Templates

-> Azure Resource Manager (ARM) Templates are a powerful feature in Microsoft Azure that allows you to define and deploy resources in Azure using a declarative JSON format. With ARM templates, you can automate the deployment of complex infrastructure and manage resources in a consistent and repeatable way.

-> Deploy Custom Template -> build ur own template -> load the json file downloaded(RG -> Settings -> Deployment) -> edit template and edit parameters

-> Azure quickstart template

- In Azure, the DNS label prefix is used to create a unique subdomain for certain resources, such as Azure Public IPs or Azure Load Balancers, that need to be accessed over the internet. 

**Where DNS Label Prefix is Used:**
- Public IPs (Static or Dynamic)
- Azure Load Balancer
- App Service

**Example of DNS Label Prefix Usage:**
**Creating a Public IP with DNS Label Prefix:**

- When you create a public IP address, you can specify the DNS label prefix.Suppose you are creating a public IP in the eastus region. You choose a DNS label prefix like mycompany-app.

- The resulting DNS name will be mycompany-app.eastus.cloudapp.azure.com.

- This means that anyone can access your public IP using the domain mycompany-app.eastus.cloudapp.azure.com, which resolves to the public IP address you associated with that DNS label.

- Managed disks are storage designed to be used with virtual machines

- Azure Resource Manager templates let you deploy, manage, and monitor all the resources for your solution as a group, rather than handling these resources individually.

- An Azure Resource Manager template is a JavaScript Object Notation (JSON) file that lets you manage your infrastructure declaratively rather than with scripts.

- Rather than passing parameters as inline values in your template, you can use a separate JSON file that contains the parameter values.

- Azure Resource Manager templates can be deployed in a variety of ways including the Azure portal, Azure PowerShell, and CLI.

- Bicep is an alternative to Azure Resource Manager templates. Bicep uses a declarative syntax to deploy Azure resources.

- Bicep provides concise syntax, reliable type safety, and support for code reuse. Bicep offers a first-class authoring experience for your infrastructure-as-code solutions in Azure.
## Quick Notes
- A virtual network is a representation of your own network in the cloud.
- When designing virtual networks it is a good practice to avoid overlapping IP address ranges. This will reduce issues and simplify troubleshooting.
- A subnet is a range of IP addresses in the virtual network. You can divide a virtual network into multiple subnets for organization and security.
- A network security group contains security rules that allow or deny network traffic. There are default incoming and outgoing rules which you can customize to your needs.
- Application security groups are used to protect groups of servers with a common function, such as web servers or database servers.
- Azure DNS is a hosting service for DNS domains that provides name resolution. You can configure Azure DNS to resolve host names in your public domain. You can also use private DNS zones to assign DNS names to virtual machines (VMs) in your Azure virtual networks.




# 🔐 Application Security Group (ASG)
## ✅ What is an Application Security Group (ASG) in Azure?
An Application Security Group is a feature in Azure networking that allows you to group virtual machines (VMs) and define network security rules based on those groups, instead of individual IP addresses.

## 🧩 Why Use ASGs?
- They help simplify network security in large-scale deployments by allowing you to:
- Group VMs by role or function (e.g., web servers, database servers).
- Apply NSG (Network Security Group) rules to entire groups rather than individual VMs.
- Avoid hardcoding IP addresses in security rules.

# Service Tag
- In Azure Network Security Groups (NSGs), a Service Tag in an inbound rule is a predefined identifier that represents a group of IP address ranges for a specific Azure service or network category.

## 🔖 What is a Service Tag?
- A Service Tag is an abstract label used in NSG rules to allow or deny traffic to or from a specific Azure service without needing to manage IP addresses manually.

## ✅ Common Service Tags
- Here are some commonly used service tags in Azure:

**Service Tag	Description**
**Internet**	All public IPv4 addresses (except Azure's own).
**VirtualNetwork**	All IPs in the same virtual network.
**AzureLoadBalancer**	Azure's internal load balancer addresses.
**AzureCloud**	All of Azure's public IP ranges.
**Storage**	Azure Storage services.
**AppGateway**	Azure Application Gateway infrastructure.
**Sql**	Azure SQL Database service IPs.
**AzureTrafficManager**	Azure Traffic Manager probes.


## DNS

## 🟦 Imagine you bought a domain:
- You bought a website name like contoso.xyz from a domain name provider (like GoDaddy or Namecheap). This is your public domain — your unique address on the internet.

## 🌐 Now you want that name to work on the internet:
- To make www.contoso.xyz point to your website (hosted on Azure), you need a DNS service to tell the internet:
- "Hey, when someone types www.contoso.xyz, send them to this IP address (your web server or app on Azure)."

## 🧭 What Azure DNS does:
- Azure DNS helps you manage that. It lets you:
- Host your domain's DNS records (like address book entries).
- Tell the internet: "www.contoso.xyz → [your website's IP address]."
- So when someone visits your site, their computer knows where to find it.

## ✅ Simple Summary:
You can use Azure DNS to link your domain name (like www.contoso.xyz) to your website's real location (its IP address). That way, people can type your domain name and get to your site — Azure handling the behind-the-scenes address lookup.

# Public Domain 

## 👨‍💻  DNS / the internet:
-> A public domain (like example.com or contoso.xyz) is:
- A unique name you register on the internet so people can find your website, email, or online services.

-> It is public because:
- It is visible and accessible on the public internet.
- Anyone can look it up (e.g., using DNS lookup tools).
- It can be accessed globally, unlike private/internal network names.

## 🔑 Example:
- You register contoso.xyz from a domain registrar. Now:

-> It's your public domain.
- You can use it for a website: www.contoso.xyz
- You can use it for email: info@contoso.xyz

# Name Server 

## 🧭 What are Name Servers?
- Think of name servers as the “phone book managers” of the internet.

-> When you create a DNS zone in Azure (like for your domain contoso.xyz), Azure gives you a set of name servers — like this:
- ns1-08.azure-dns.com  
- ns2-08.azure-dns.net  
- ns3-08.azure-dns.org  
- ns4-08.azure-dns.info

## 🔧 What do they do?

- "What is the IP address of www.contoso.xyz?"
- So when someone types www.contoso.xyz into their browser:
- The internet asks your name servers,
- The name servers check your DNS records,

**They reply:**
→ “Send them to 52.187.25.65” (your web server's IP).

# 💡 Why do you get name servers in Azure?
-> When you create a DNS zone in Azure:
- Azure becomes the DNS provider for your domain.
- These Azure name servers are the ones that answer DNS lookups for your domain.

# 📬 What you need to do ():
-> After creating your DNS zone, you go to your domain registrar (like GoDaddy, Namecheap) and:
- 👉 Replace their default name servers with the Azure name servers.

-> That tells the internet:
- “Hey, Azure is now in charge of DNS for contoso.xyz.”

## ✅ Simple Summary
- Name servers are like the address keepers for your domain. When you use Azure DNS, Azure gives you name servers that tell the world how to find your website or services using your domain name.


# Record Sets

## 📇 What are Record Sets?
- Think of record sets as entries in your domain’s address book.
- They tell the internet where to send traffic when someone tries to visit your domain or use services like email.

## 💬 Example:
-> You have a domain like:
- contoso.xyz

- Inside your DNS zone for this domain, you create record sets like:

**Type	Name	Points to	Purpose**
- A	www	52.187.25.65	Sends visitors to your website
- CNAME	shop	store.contoso.xyz	Redirects to another name
- MX	(empty / @)	mail.contoso.xyz	Handles your email
- TXT	(empty / @)	v=spf1 include:...	Email security info

## 🧱 What’s inside a Record Set?
-> Each record set includes:
- A type (A, CNAME, MX, TXT, etc.)
- A name (like www or mail)
- A value (like an IP address or domain)
- An optional TTL (how long it’s cached)

# 🧭 What it means for you:
- When someone visits www.contoso.xyz:
- Their computer asks your name servers,
- Name servers check your record sets,
- They find the A record for www,

- They reply: "Go to 52.187.25.65" — and the browser connects to your website.

## ✅ Simple Summary
- Record sets are like the instructions in your domain’s address book. They tell the internet where to send people when they visit your website, send you email, or use your services — all based on your domain name.

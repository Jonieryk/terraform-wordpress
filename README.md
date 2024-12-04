# Terraform WordPress AWS Setup

This repository contains Terraform configurations to deploy a WordPress website with a MySQL database on AWS. The setup uses an EC2 instance with Apache, PHP, and WordPress installed, along with a MySQL database for storing WordPress data.

***This repository should only be used for learning and is not in any way safe for use in production or any other serious application.***
## Prerequisites

Before you begin, make sure you have the following:

- **Terraform** installed on your machine (preferably version 1.3 or above).
- **AWS CLI** configured with appropriate credentials and permissions.
- **An SSH key pair** for accessing the EC2 instance.

### 1. **Clone the Repository**

Clone this repository to your local machine:

```bash
git clone https://github.com/Jonieryk/terraform-wordpress.git
cd terraform-wordpress
```

If you do not have a key pair, you can create one named cli-ssh-key, as it is the default one in the values.tf file.

```bash
aws ec2 create-key-pair --key-name cli-ssh-key --query 'KeyMaterial' --output text > cli-ssh-key.pem
```

You can create your own name for the key pair and add a terraform.tfvars file to your cloned repo to change the value.

### 2. **Run the instance**

To run the instance initialize terraform and apply it.

```bash
terraform init
terraform apply
```
Check what will be installed and type 'yes'.
Your instance should start getting set up on your AWS account.

### **3. Accessing your site**

To access your wordpress site check the ip of the EC2 instance.

```bash
aws ec2 describe-instances --query "Reservations[*].Instances[].[InstanceId, PublicIpAddress]" --output table
```

Copy the ip to your browser and set up wordpress.

After these steps, you should have wordpress running on a EC2 instance with a MySQL database.

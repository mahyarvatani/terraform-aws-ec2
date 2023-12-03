# Terraform AWS Customized VPC Project

## Overview

This Terraform project automates the creation of a customized AWS VPC, subnet, route table, internet gateway, EC2 instance with a deployed Nginx Docker container, and a security group. The infrastructure is designed for a simple web application with restricted access.

## Prerequisites

Before using this Terraform configuration, make sure you have the following prerequisites:

1. [Terraform](https://www.terraform.io/) installed on your machine.
2. AWS credentials configured with appropriate permissions.

## Getting Started

1. Clone this repository to your local machine:

    ```bash
    git clone https://github.com/your-username/terraform-aws-customized-vpc.git
    cd terraform-aws-customized-vpc
    ```

2. Initialize the Terraform project:

    ```bash
    terraform init
    ```

3. Customize the `terraform.tfvars` file with your AWS credentials and any other variables you want to modify.

4. Review and adjust the `main.tf` file if necessary to match your requirements.

## Usage

To create the infrastructure, run the following Terraform commands:

```bash
terraform plan          # Review the changes that will be applied
terraform apply         # Apply the changes to create the infrastructure
```

After successfully applying the changes, Terraform will output information about the created resources, including the public IP address of the EC2 instance.

Cleaning Up
To destroy the created infrastructure, run:

```bash
terraform destroy
```
Confirm the destruction when prompted.

## Terraform Modules

- **VPC**: Creates a customized Virtual Private Cloud (VPC).
- **Subnet**: Creates a customized subnet within the VPC.
- **Route Table**: Creates a route table associated with the VPC.
- **Internet Gateway**: Creates an internet gateway and associates it with the VPC.
- **EC2 Instance**: Creates an EC2 instance with a deployed Nginx Docker container.
- **Security Group**: Creates a security group allowing SSH and port 8080 access.

The infrastructure is designed for a simple web application with restricted access.


Contributing
If you'd like to contribute to this project, please follow the guidelines in CONTRIBUTING.md.








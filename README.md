# AWS 3-Tier Architecture with Terraform

## Overview

This project sets up a 3-tier architecture on AWS using Terraform. The 3-tier architecture is a well-established software architecture pattern that divides an application into three main logical layers: Presentation Tier, Application Tier, and Data Tier. This separation improves scalability, redundancy, and fault tolerance.

## What is a 3-Tier Architecture?

A 3-tier architecture consists of the following layers:

1. **Presentation Tier**: This is the topmost level of the application, the user interface. In a web application, this is typically a web server or a load balancer that handles HTTP requests and responses.
2. **Application Tier**: Also known as the middle tier or logic tier, this layer contains the functional business logic that drives the application's core capabilities. It processes the data passed from the Presentation Tier and interacts with the Data Tier.
3. **Data Tier**: This layer is where the application's data is stored and managed. It typically involves a database server where the data resides.

## Benefits of a 3-Tier Architecture

### Scalability

- **Horizontal Scaling**: Each tier can be scaled independently. For example, if the web traffic increases, more web servers can be added to the Presentation Tier without affecting the Application or Data Tiers.
- **Load Balancing**: Load balancers can be used in the Presentation and Application Tiers to distribute traffic evenly across multiple servers, ensuring no single server becomes a bottleneck.

### Redundancy

- **Multiple Instances**: By running multiple instances in each tier, the architecture can continue to operate even if one instance fails.
- **Failover Mechanisms**: In the Data Tier, if the main database fails, a backup database can automatically take over.

### Fault Tolerance

- **Isolation of Tiers**: Each tier is isolated from the others. If an issue arises in one tier, it does not directly affect the other tiers. For example, a failure in the Application Tier does not bring down the web servers in the Presentation Tier or the databases in the Data Tier.
- **Automated Recovery**: AWS offer services that can automatically recover instances, replace unhealthy ones, and maintain the desired state of the architecture, contributing to overall fault tolerance.

## Project Structure

- Configure the AWS provider.
- Define VPC, subnets, internet gateway, and route tables.
- Define security groups for each tier.
- Launch EC2 instances for the web, application, and database servers.
- Provide the output variables such as public and private IPs of the instances.

## How to Deploy

1. **Install Terraform**: Ensure Terraform is installed on your local machine.
2. **AWS Credentials**: Configure AWS CLI with your credentials.
3. **Initialize Terraform**: Run `terraform init` to initialize the configuration.
4. **Apply Configuration**: Run `terraform apply` to create the infrastructure. Review the changes and approve the plan.

```sh
terraform init
terraform apply

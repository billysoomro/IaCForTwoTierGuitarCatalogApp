# AWS Infrastructure Setup with Terraform

This repository contains a Terraform script to create a basic Two-tier AWS infrastructure setup to host the GuitarCatalogApp made up of the SimpleFrontEnd and the SimpleCrudApi. The provided Terraform script within the IaC folder handles the creation of a VPC, subnets, and necessary gateways in the EU-West-2 region. Please note that some components have been omitted for the sake of brevity. The Terraform script in this repository creates the following infrastructure components:

### VPC
- A Virtual Private Cloud (VPC) in the EU-West-2 region.

### Subnets
- A set of private and public subnets in availability zone 2a.
- A set of private and public subnets in availability zone 2b.

### Internet Gateway
- Attaches an internet gateway and routes traffic to the public subnets.

### DynamoDB Gateway Endpoint
- Creates a gateway endpoint for DynamoDB to facilitate private communication from the private subnets.

### Prerequisites
- Terraform installed on your machine.
- AWS credentials configured on your machine.

### Infrastructure Diagram
The diagram below illustrates the complete design for the Two-tier infrastructure (some components have been omitted from the terraform script for the sake of brevity).

![AWS Infrastructure](InfrastructureDiagram/Two%20Tier%20Architecture.jpg)

### Future Enhancements
- Integration with additional AWS services.
- Enhanced security configurations.

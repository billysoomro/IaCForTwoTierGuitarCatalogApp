provider "aws" {
  region = "eu-west-2"
}

# Create VPC
resource "aws_vpc" "terraform_generated_vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "terraform-generated-vpc"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "terraform_generated_igw" {
  vpc_id = aws_vpc.terraform_generated_vpc.id
  tags = {
    Name = "terraform-generated-igw"
  }
}

# Create Public Subnets
resource "aws_subnet" "public_subnet_2a" {
  vpc_id            = aws_vpc.terraform_generated_vpc.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-a"
  }
}

resource "aws_subnet" "public_subnet_2b" {
  vpc_id            = aws_vpc.terraform_generated_vpc.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-b"
  }
}

# Create Private Subnets
resource "aws_subnet" "private_subnet_2a" {
  vpc_id            = aws_vpc.terraform_generated_vpc.id
  cidr_block        = "10.1.3.0/24"
  availability_zone = "eu-west-2a"
  tags = {
    Name = "private-subnet-a"
  }
}

resource "aws_subnet" "private_subnet_2b" {
  vpc_id            = aws_vpc.terraform_generated_vpc.id
  cidr_block        = "10.1.4.0/24"
  availability_zone = "eu-west-2b"
  tags = {
    Name = "private-subnet-b"
  }
}

# Create Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.terraform_generated_vpc.id
  tags = {
    Name = "public-rt"
  }
}

# Create route to Internet Gateway
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.terraform_generated_igw.id
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public_subnet_2a" {
  subnet_id      = aws_subnet.public_subnet_2a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnet_2b" {
  subnet_id      = aws_subnet.public_subnet_2b.id
  route_table_id = aws_route_table.public.id
}

# Create DynamoDB Gateway Endpoint
resource "aws_vpc_endpoint" "terraform_generated_dynamodb_endpoint" {
  vpc_id       = aws_vpc.terraform_generated_vpc.id
  service_name = "com.amazonaws.eu-west-2.dynamodb"
  vpc_endpoint_type = "Gateway"
  
  route_table_ids = [
    aws_subnet.private_subnet_2a.id,
    aws_subnet.private_subnet_2b.id
  ]

  tags = {
    Name = "terraform-generated-dynamodb-endpoint"
  }
}

output "vpc_id" {
  value = aws_vpc.terraform_generated_vpc.id
}

output "public_subnets" {
  value = [aws_subnet.public_subnet_2a.id, aws_subnet.public_subnet_2b.id]
}

output "private_subnets" {
  value = [aws_subnet.private_subnet_2a.id, aws_subnet.private_subnet_2b.id]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.terraform_generated_igw.id
}

output "dynamodb_endpoint_id" {
  value = aws_vpc_endpoint.terraform_generated_dynamodb_endpoint.id
}

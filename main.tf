provider "aws" {
  region  = "us-east-2"
  profile = "aminaupskill2"
}

# VPC 

resource "aws_vpc" "three_tier_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "3-Tier-Architecture-VPC"
  }
}

# Internet Gateway for VPC to have internet connectivity

resource "aws_internet_gateway" "three_tier_ig" {
  vpc_id = aws_vpc.three_tier_vpc

  tags = {
    Name = "3-Tier-Architecture-IG"
  }
}

# Public RT for Web Tier

resource "aws_route_table" "three_tier_public_RT" {
  vpc_id = aws_vpc.three_tier_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.three_tier_ig.id
  }

  tags = {
    Name = "3-Tier-Public-RT"
  }

}

# Public/Web RT Associations 

resource "aws_route_table_association" "public_RT_1" {
  route_table_id = aws_route_table.three_tier_public_RT.id
  subnet_id      = module.public_web_subnet_1.subnet_id
}

resource "aws_route_table_association" "public_RT_2" {
  route_table_id = aws_route_table.three_tier_public_RT.id
  subnet_id      = module.public_web_subnet_2.subnet_id
}

# Private RT for Application Tier 

resource "aws_route_table" "three_tier_private_RT" {
  vpc_id = aws_vpc.three_tier_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.three_tier-NAT.vpc_id
  }

  tags = {
    Name = "3-Tier-Private-RT"
  }

}

# Private App RT Associations 

resource "aws_route_table_association" "private_RT_1" {
  route_table_id = aws_route_table.three_tier_private_RT.id
  subnet_id      = module.private_app_subnet_1.id
}

resource "aws_route_table_association" "private_RT_2" {
  route_table_id = aws_route_table.three_tier_private_RT.id
  subnet_id      = module.private_app_subnet_2.id
}

# Private Route Table for Data Tier

resource "aws_route_table" "three_tier_DB_RT" {
  vpc_id = aws_vpc.three_tier_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.three_tier_NAT_DB.subnet_id
  }

  tags = {
    Name = "3-Tier-DB-RT"
  }

}

# DATA TIER RT associations 

resource "aws_route_table_association" "data_RT_1" {
  route_table_id = aws_route_table.three_tier_DB_RT.id
  subnet_id      = module.Private_DB_subnet_1.route_table_id

}

resource "aws_route_table_association" "data_RT_2" {
  route_table_id = aws_route_table.three_tier_DB_RT.id
  subnet_id      = module.Private_DB_subnet_2.route_table_id

}

# NAT Gateway for Secured Internet Connectivity to Private Subnets- Located in the Public Subnet 

resource "aws_nat_gateway" "three_tier-NAT" {
  subnet_id     = module.public_web_subnet_1.subnet_id
  allocation_id = aws_eip.NAT-eip.arn

  tags = {
    Name = "3-Tier-NAT"
  }

  depends_on = [aws_internet_gateway.three_tier_ig]
}

resource "aws_eip" "NAT-eip" {
  domain = "vpc"
}

# NAT Gateway for secured internet connectivity to DB Tier 

resource "aws_nat_gateway" "three_tier_NAT_DB" {
  subnet_id     = module.public_web_subnet_2.subnet_id
  allocation_id = aws_eip.NAT-eip.id

  tags = {
    Name = "Three-Tier-DB-NAT"
  }

  depends_on = [aws_internet_gateway.three_tier_ig]

}

resource "aws_eip" "NAT_DB_eip" {
  domain = "vpc"
}
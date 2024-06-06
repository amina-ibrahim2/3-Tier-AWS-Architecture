# Public Subnets

module "public_web_subnet_1" {
  source                  = "./modules/subnet"
  vpc_id                  = aws_vpc.three_tier_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-2a"
  Name                    = "3-Tier-Public-AZ1"
  map_public_ip_on_launch = true
}

module "public_web_subnet_2" {
  source                  = "./modules/subnet"
  vpc_id                  = aws_vpc.three_tier_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-2b"
  Name                    = "3-Tier-Public-AZ2"
  map_public_ip_on_launch = true
}

module "private_app_subnet_1" {
  source            = "./modules/subnet"
  vpc_id            = aws_vpc.three_tier_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-2a"
  Name              = "3-Tier-Private-App-AZ1"
}

module "private_app_subnet_2" {
  source            = "./modules/subnet"
  vpc_id            = aws_vpc.three_tier_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-2b"
  Name              = "3-Tier-Private-App-AZ2"
}

module "Private_DB_subnet_1" {
  source            = "./modules/subnet"
  vpc_id            = aws_vpc.three_tier_vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-2a"
  Name              = "3-Tier-Private-DB-AZ1"
}

module "Private_DB_subnet_2" {
  source            = "./modules/subnet"
  vpc_id            = aws_vpc.three_tier_vpc.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = "us-east-2b"
  Name              = "3-Tier-Private-DB-AZ2"
}

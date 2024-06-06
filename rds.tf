# Subnet groups for RDS database to connect to data tier subnets 

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "three-tier-subnet-group"
  subnet_ids = [module.Private_DB_subnet_1.id,module.Private_DB_subnet_2.id]

  tags = {
    Name = "Subnet group for Three-Tier Architecture"
  }
}


resource "aws_db_instance" "data_tier_db" {
  allocated_storage           = 10
  db_name                     = "Data_Tier_DB"
  engine                      = "mysql"
  engine_version              = "8.0.32"
  instance_class              = "db.t3.micro"
  manage_master_user_password = true
  username                    = "admin"
  db_subnet_group_name        = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids      = [aws_security_group.db_tier_sg.id]
}
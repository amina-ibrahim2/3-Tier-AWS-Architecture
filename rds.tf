# Subnet groups for RDS database to connect to data tier subnets 

resource "aws_db_subnet_group" "db_subnet_group" {
    name = "three-tier-subnet-group"
    subnet_ids = [module.Private_DB_subnet_1.id, module.Private_DB_subnet_2.id]

    tags = {
        Name = "Subnet group for Three-Tier Architecture"
    }  
}

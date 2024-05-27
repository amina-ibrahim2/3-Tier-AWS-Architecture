# Security Groups for Application Tier 

resource "aws_security_group" "three_tier_app_sg" {
    name = "three_tier_app_sg"
    description = "Security group for app servers on web/app tier"
    vpc_id = aws_vpc.three_tier_vpc.id

    ingress {
        description = "SSH into the instance from bastion host"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [ aws_security_group.bastion_host_sg.id ]
    }

    ingress {
        description = "Allow connectivity from LB"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [ aws_security_group.three_tier_lb_sg.id ]
    }

    egress {
        description = "Allow Outbound Connectivity"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]  
    }

    tags = {
        Name = "three-tier_app_sg"
    }
  
}

# Security Group for Data Tier 

resource "aws_security_group" "db_tier_sg" {
    name = "three-tier_db-sg"
    description = "Allow application tier to communicate with database tier"
    vpc_id = aws_vpc.three_tier_vpc.id

    ingress {
        description = "Allow connection to database"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [ aws_security_group.three_tier_app_sg ]
    }

    tags = {
        Name = "three-tier_db-sg"
    }
  
}

# Security Group for Load Balancer facing Web Tier

resource "aws_security_group" "three_tier_lb_sg" {
    name = "three-tier_LB-sg"
    description = "Security group for load balancer facing web/application tier"
    vpc_id = aws_vpc.three_tier_vpc.id

    ingress {
        description = "Access to webpage"
        from_port = 80 
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress { 
        description = "Allow all outbound connectivity"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
     }

     tags = {
        Name = "three-tier_LB-sg"
     }
}


# Security Group for Bastion Host 

resource "aws_security_group" "bastion_host_sg" {
    name = "three-tier_bastion-host-sg"
    description = "security group for bastion host on the presentation layer "
    vpc_id = aws_vpc.three_tier_vpc.id 
  
    ingress {
        description = "SSH into instance"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]   
    }

    egress {
        description = "Allow outbound connectivity"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]   
    }

    tags = {
        Name = "three-tier_bastion-host-sg"
    }
}


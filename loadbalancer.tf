resource "aws_lb" "three-tier_LB" {
    name = "Three-Tier-LB"
    internal = false 
    load_balancer_type = "application"
    security_groups = [aws_security_group.three_tier_lb_sg.id]

    subnet_mapping {
      subnet_id = module.public_web_subnet_1.id 
    }

    subnet_mapping {
      subnet_id = module.public_web_subnet_2.id 
    }
 }
    
# Load Balancer target group 

resource "aws_lb_target_group" "three_tier_lb_tg" {
    name = "Three-Tier-tg"
    port = 80
    protocol = "HTTP"
    target_type = "instance"
    vpc_id = aws_vpc.three_tier_vpc.id

    stickiness {
      enabled = false 
      type = "app_cookie"
    }
}

resource "aws_lb_listener" "lb_listener" {
    load_balancer_arn = aws_lb.three_tier_LB.certificate_arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.three_tier_lb_tg.arn
    }
  
}
  

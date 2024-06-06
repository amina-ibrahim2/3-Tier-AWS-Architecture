resource "aws_launch_template" "app_tier_instances" {
  name                   = "Three-Tier-Launch-Template"
  image_id               = "ami-09988af04120b3591"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.three_tier_key_pair.key_name
  user_data              = filebase64("${path.module}/launch_data.sh")
  vpc_security_group_ids = [aws_security_group.three_tier_app_sg.id]
}

resource "aws_autoscaling_group" "app_tier_asg" {
  desired_capacity    = 3
  min_size            = 2
  max_size            = 10
  vpc_zone_identifier = [module.private_app_subnet_2.id, module.private_app_subnet_2.id]
  target_group_arns   = [aws_lb_target_group.three_tier_lb_tg.arn]
  health_check_type   = "EC2"
  force_delete        = true

  launch_template {
    id      = aws_launch_template.app_tier_instances.id
    version = "$Latest"
  }

}

# Bastion Host Instance
resource "aws_instance" "three_tier_bastion_host" {
  ami                    = "ami-09988af04120b3591"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.three_tier_key_pair.key_name
  subnet_id              = module.public_web_subnet_1.id
  vpc_security_group_ids = [aws_security_group.bastion_host_sg.id]


  tags = {
    Name = "Three-Tier-Bastion-Host"
  }
}




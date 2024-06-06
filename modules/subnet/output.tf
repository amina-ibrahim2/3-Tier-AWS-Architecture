output "id" {
  value = aws_subnet.main.arn
}

output "lb_dns_name" {
  value = aws_lb.three-tier_LB.dns_name
}



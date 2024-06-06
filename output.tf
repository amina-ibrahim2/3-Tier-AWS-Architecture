output "id" {
  value = aws_subnet.main.id
}

output "lb_dns_name" {
  value = aws_lb.three-tier_LB.dns_name
}



output "web1_public_ip" {
  value = aws_instance.web1.public_ip
}

output "web2_public_ip" {
  value = var.create_second_ec2 ? aws_instance.web2[0].public_ip : null
}

output "alb_dns_name" {
  value = var.enable_alb ? aws_lb.alb[0].dns_name : null
}

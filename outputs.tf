output "web1_public_ip" {
  value = module.compute.web1_public_ip
}

output "web2_public_ip" {
  value = module.compute.web2_public_ip
}

output "alb_dns_name" {
  value = module.compute.alb_dns_name
}

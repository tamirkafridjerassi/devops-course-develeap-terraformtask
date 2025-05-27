provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "./modules/network"
  aws_region       = var.aws_region 
  project_tag     = var.project_tag
  vpc_cidr        = var.vpc_cidr
  subnet_a_cidr   = var.subnet_a_cidr
  subnet_b_cidr   = var.subnet_b_cidr
  create_subnet_b = var.create_subnet_b
}

module "compute" {
  source = "./modules/compute"

  project_tag         = var.project_tag
  instance_type       = var.instance_type
  key_name            = var.key_name
  create_second_ec2   = var.create_second_ec2
  subnet_a_id         = module.network.subnet_a_id
  subnet_b_id         = module.network.subnet_b_id
  vpc_id              = module.network.vpc_id
  enable_alb = var.enable_alb
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_tag" {
  description = "Name tag for all resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_a_cidr" {
  description = "CIDR block for Subnet A"
  type        = string
}

variable "subnet_b_cidr" {
  description = "CIDR block for Subnet B"
  type        = string
  default     = null
}

variable "create_subnet_b" {
  description = "Whether to create Subnet B"
  type        = bool
  default     = false
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "create_second_ec2" {
  description = "Whether to create second EC2 in Subnet B"
  type        = bool
  default     = false
}
variable "enable_alb" {
  description = "Toggle whether to create an ALB"
  type        = bool
  default     = false
}

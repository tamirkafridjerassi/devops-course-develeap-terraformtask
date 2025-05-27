variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_tag" {
  description = "Project tag for naming resources"
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
  description = "CIDR block for Subnet B (used if create_subnet_b is true)"
  type        = string
  default     = null
}

variable "create_subnet_b" {
  description = "Toggle to create second subnet"
  type        = bool
  default     = false
}

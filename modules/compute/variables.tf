variable "project_tag" {
  description = "Project name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "subnet_a_id" {
  description = "Subnet A ID"
  type        = string
}

variable "subnet_b_id" {
  description = "Subnet B ID"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "create_second_ec2" {
  description = "Create second EC2 in Subnet B"
  type        = bool
  default     = false
}

variable "enable_alb" {
  description = "Enable Application Load Balancer"
  type        = bool
  default     = false
}

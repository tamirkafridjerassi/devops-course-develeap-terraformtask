resource "aws_security_group" "web_sg" {
  name        = "${var.project_tag} - web-sg"
  description = "Allow SSH and HTTP (port 3000)"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_tag} - SG"
    Project = var.project_tag
  }
}

resource "aws_instance" "web1" {
  ami                         = "ami-0287a05f0ef0e9d9a"
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_a_id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name
  user_data                   = file("${path.module}/user_data.sh")

  tags = {
    Name    = "${var.project_tag} - EC2 A"
    Project = var.project_tag
  }
}

resource "aws_instance" "web2" {
  count                       = var.create_second_ec2 ? 1 : 0
  ami                         = "ami-0287a05f0ef0e9d9a"
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_b_id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name
  user_data                   = file("${path.module}/user_data.sh")

  tags = {
    Name    = "${var.project_tag} - EC2 B"
    Project = var.project_tag
  }
}

resource "aws_security_group" "alb_sg" {
  count = var.enable_alb ? 1 : 0

  name        = "${var.project_tag} - ALB SG"
  description = "Allow HTTP"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_tag} - ALB SG"
    Project = var.project_tag
  }
}

resource "aws_lb" "alb" {
  count               = var.enable_alb ? 1 : 0
  name = "${replace(var.project_tag, " ", "-")}-alb"
  internal            = false
  load_balancer_type  = "application"
  security_groups     = [aws_security_group.alb_sg[0].id]
  subnets             = [var.subnet_a_id, var.subnet_b_id]

  tags = {
    Name    = "${var.project_tag} - ALB"
    Project = var.project_tag
  }
}

resource "aws_lb_target_group" "tg" {
  count      = var.enable_alb ? 1 : 0
  name = "${replace(var.project_tag, " ", "-")}-tg"
  port       = 3000
  protocol   = "HTTP"
  vpc_id     = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    port                = "3000"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.project_tag} - TG"
  }
}

resource "aws_lb_listener" "http" {
  count             = var.enable_alb ? 1 : 0
  load_balancer_arn = aws_lb.alb[0].arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg[0].arn
  }
}

resource "aws_lb_target_group_attachment" "web1_attach" {
  count            = var.enable_alb ? 1 : 0
  target_group_arn = aws_lb_target_group.tg[0].arn
  target_id        = aws_instance.web1.id
  port             = 3000
}

resource "aws_lb_target_group_attachment" "web2_attach" {
  count            = var.create_second_ec2 && var.enable_alb ? 1 : 0
  target_group_arn = aws_lb_target_group.tg[0].arn
  target_id        = aws_instance.web2[0].id
  port             = 3000
}

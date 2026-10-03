data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }
}

resource "aws_security_group" "app_web_sg" {
  name        = "app_web_sg"
  description = "Security group for the web application"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["38.25.51.69/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    aws_security_group.app_web_sg.id
  ]

  tags = {
    Name = "Terraform-ec2-web_server"
  }
}
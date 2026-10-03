data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }
}

module "vpc" {
  source     = "../../modules/vpc"
  cidr_block = "10.0.0.0/16"
}

module "ec2" {
  source        = "../../modules/ec2"
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  vpc_id        = module.vpc.vpc_id
}
variable "aws_region" {
  description = "Region donde vamos a desplegar los recursos de AWS"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Tipo de instancia EC2 a desplegar"
  type        = string
  default     = "t3.micro"
}

variable "vpc_id" {
  description = "ID del VPC donde se desplegarán los recursos"
  type        = string
}
variable "ami" {
    description = "The AMI ID for the EC2 instance"
    type        = string
}

variable "instance_type" {
    description = "The instance type for the EC2 instance"
    type        = string
}

variable "vpc_id" {
    description = "The ID of the VPC where the EC2 instance will be launched"
    type        = string
}
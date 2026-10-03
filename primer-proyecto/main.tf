provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "bucket-demo" {
  bucket = "primer-bucket-aws-terraform"
  
  tags = {
    Name        = "primer-bucket-aws-terraform"
    Environment = "Dev"
  }
}
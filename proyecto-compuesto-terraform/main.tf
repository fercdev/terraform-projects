resource "aws_s3_bucket" "app_bucket" {
  bucket = var.bucket_name

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_iam_user" "developer" {
  name = var.iam_user_name

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}
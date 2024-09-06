terraform {
  required_version = "~> 1.9.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.65.0"
    }
  }
  backend "s3" {
    bucket         = "devsecops-bucketone"
    region         = "ap-south-1"
    key            = "ecs/terraform.tfstate"
    dynamodb_table = "devsecops-dynamodb-table"
    encrypt        = true
  }
}
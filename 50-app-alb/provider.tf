terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.92.0"
    }
  }
  backend "s3" {
      bucket = "hari-81s-remote-state"
      key    = "expense-app-alb-dev"
      region = "us-east-1"
      dynamodb_table = "Hari-81s-locking"
  }

}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.96.0"
    }
  }
  backend "s3" {
      bucket = "hari-81s-remote-state"
      key    = "expense-dev-web-alb"
      region = "us-east-1"
      dynamodb_table = "Hari-81s-locking"
  }

}


provider "aws" {
  # Configuration options
  region = "us-east-1"
}
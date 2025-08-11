terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.99.1"
    }
  }
  backend "s3" {
    bucket = "daws2025.online-remote"
    key    = "ec2-module-vpn-dev"
    region = "us-east-1"
    encrypt      = true  
    use_lockfile = true  #S3 native locking
    # dynamodb_table = "daws2025.online-state"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}
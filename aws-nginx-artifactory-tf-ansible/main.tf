provider "aws" {
  region = "${var.aws_region}"
  profile = "${var.aws_profile}"
}


# This s3 bucket will store the actual tfstate

terraform {
  backend "s3" {
    bucket = "ujjwal-nginx-artifactory"
    key = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
}


# Deploy Storage Resource
# we actually don't need it, but anyway create it
module "storage" {
  source       = "./storage"
  project_name = "${var.project_name}"
}
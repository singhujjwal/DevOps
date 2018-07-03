provider "aws" {
  region = "${var.aws_region}"
  profile = "${var.aws_profile}"
}


# This s3 bucket will store the actual tfstate
# Run it with  AWS_PROFILE=superhero terraform init otherwise gives 403 error
terraform {
  backend "s3" {
    bucket = "terraform-states-ujjwal"
    key = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
}


# Deploy Storage Resource
# we actually don't need it, but anyway create it
#module "storage" {
#  source       = "./storage"
#  project_name = "${var.project_name}"
#}

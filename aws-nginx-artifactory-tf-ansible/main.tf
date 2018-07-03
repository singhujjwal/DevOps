provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

# This s3 bucket will store the actual tfstate
# Run it with  AWS_PROFILE=superhero terraform init otherwise gives 403 error
terraform {
  backend "s3" {
    bucket = "terraform-states-ujjwal"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
}

# Deploy Storage Resource
# we actually don't need it, but anyway create it
module "storage" {
  source       = "./storage"
  project_name = "${var.project_name}"
}

module "networking" {
  source       = "./networking"
  vpc_cidr     = "${var.vpc_cidr}"
  public_cidrs = "${var.public_cidrs}"
  accessip     = "${var.accessip}"
}

# Deploy Compute Resources

module "compute" {
  source          = "./compute"
  instance_count  = "${var.instance_count}"
  key_name        = "${var.key_name}"
  public_key_path = "${var.public_key_path}"
  instance_type   = "${var.server_instance_type}"
  subnets         = "${module.networking.public_subnets}"
  security_group  = "${module.networking.public_sg}"
  subnet_ips      = "${module.networking.subnet_ips}"
}


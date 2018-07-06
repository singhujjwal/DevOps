provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

# This s3 bucket will store the actual tfstate
# Run it with  AWS_PROFILE=superhero terraform init otherwise gives 403 error
#terraform {
#  backend "s3" {
#    bucket = "terraform-states-ujjwal"
#    key    = "terraform/terraform.tfstate"
#    region = "us-east-1"
#  }
##}

####################################
# Commented as running out of free tier usage

# Deploy Storage Resource
# we actually don't need it, but anyway create it
#module "storage" {
#  source       = "./storage"
#  project_name = "${var.project_name}"
#}

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
  aws_profile     = "${var.aws_profile}"
}


#---------Route53-------------

#primary zone

resource "aws_route53_zone" "primary" {
  name              = "${var.domain_name}.in"
  delegation_set_id = "${var.delegation_set}"
}

#www 

resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "www.${var.domain_name}.in"
  type    = "A"
  ttl = "300"
  records = ["${module.compute.server_ip_list}"]

}

resource "aws_route53_record" "nowww" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "${var.domain_name}.in"
  type    = "A"
  ttl = "300"
  records = ["${module.compute.server_ip_list}"]
}

#dev 

#resource "aws_route53_record" "dev" {
  #zone_id = "${aws_route53_zone.primary.zone_id}"
  #name    = "dev.${var.domain_name}.in"
  #type    = "A"
  #ttl     = "300"
  #records = ["${aws_instance.wp_dev.public_ip}"]
#}

#secondary zone

#resource "aws_route53_zone" "secondary" {
  #name   = "${var.domain_name}.in"
  #vpc_id = "${aws_vpc.wp_vpc.id}"
#}

#db 

#resource "aws_route53_record" "db" {
  #zone_id = "${aws_route53_zone.secondary.zone_id}"
  ##name    = "db.${var.domain_name}.in"
  #type    = "CNAME"
  #ttl     = "300"
  #records = ["${aws_db_instance.wp_db.address}"]
#}

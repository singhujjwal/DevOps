variable "aws_region" {}
variable "aws_profile" {}
variable "project_name" {}

#----- Networking variables

variable "vpc_cidr" {}

variable "public_cidrs" {
  type = "list"
}

variable "accessip" {}

#-------compute variables

variable "key_name" {}

variable "public_key_path" {}

variable "server_instance_type" {}

variable "instance_count" {
  default = 1
}

variable "domain_name" {
  default="singhjee"
}

variable "delegation_set" {}

variable "aws_region" {}
variable "aws_profile" {}
variable "project_name" {}

#----- Networking variables

variable "vpc_cidr" {}

variable "public_cidrs" {
  type = "list"
}

variable "accessip" {}

output "Subnets are " {
  value = "${module.networking.public_subnets}"
}

output "The instance IPs are" {
  value = "${module.compute.server_ip}"
}

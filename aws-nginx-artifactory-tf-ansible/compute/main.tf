#-------compute/main.tf------

data "aws_ami" "server_ami" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "tf_auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "null_resource" "host_file" {
  provisioner "local-exec" {
    command = <<EOD
cat <<EOF > aws_hosts
[dev]
EOF
EOD
  }
}

resource "aws_instance" "tf_server" {
  count         = "${var.instance_count}"
  instance_type = "${var.instance_type}"
  ami           = "${data.aws_ami.server_ami.id}"

  tags {
    Name = "tf_server-${count.index +1}"
  }

  key_name               = "${aws_key_pair.tf_auth.id}"
  vpc_security_group_ids = ["${var.security_group}"]
  subnet_id              = "${element(var.subnets, count.index)}"

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> aws_hosts"
  }

  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${self.id} --profile ${var.aws_profile} && ansible-playbook -i aws_hosts apache.yml --limit ${self.public_ip}"
  }
 
}




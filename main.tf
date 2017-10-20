provider "aws" {
  access_key = "********"
  secret_key = "********"
  region = "us-east-2"
}
resource "aws_instance" "openmrs-unhm" {
  ami                         = "ami-835b4efa"
  instance_type               = "m4.large"
  ebs_optimized               = true
  monitoring                  = false
  associate_public_ip_address = true

  user_data                   = "${file("setup-env.sh")}"

  availability_zone           = "us-east-2a"
  key_name                    = "openmrs-unhm"

  root_block_device {
    volume_type               = "gp2"
    volume_size               = 60
    delete_on_termination     = false
  }
  tags {
    "Environment"= "unhm"
    "Name"= "openmrs-unhm"
  }
}
output "ssh_sandbox" {
  value = "ssh -l openmrs-unhm.pem ec2-user@${aws_instance.openmrs-unhm.public_ip}"
}

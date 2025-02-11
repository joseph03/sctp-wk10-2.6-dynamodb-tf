#used by vpc
 data "aws_availability_zones" "available" {
  state = "available"
}

#used by ec2 creation
data "aws_ami" "specific_al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.6.20250115.0-kernel-6.1-x86_64"] #find this version
  }
}
/* hardcoded
resource "aws_instance" "public_instance" {
  ami           = "ami-xxxxxxxxxxxxxx"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnets[0]  # Place in a public subnet
  key_name      = "my-key-pair"  # Replace with your key pair name
  security_groups = [aws_security_group.public_sg.id]

  tags = {
    Name = "public-instance"
  }
}
*/

#assign access key, vpc, subnet and security group and ec level
resource "aws_instance" "my_instance" {
  ami                    = data.aws_ami.specific_al2023.id  # Use the dynamically fetched AMI
  instance_type          = "t2.micro"
  subnet_id              = module.vpc.public_subnets[0]
  key_name               = "joseph_key"
  security_groups        = [aws_security_group.public_sg.id]
  associate_public_ip_address = true  # This will assign a public IP to the instance

  iam_instance_profile = aws_iam_instance_profile.ec2_role.name  # Attach the IAM role to the instance

  tags = {
    Name = "joseph-al2023-instance"
  }
}

#instance profile to associate IAM role to ec2 instance
resource "aws_iam_instance_profile" "ec2_role" {
  name = "ec2-dynamodb-read-instance-profile"
  role = aws_iam_role.ec2_role.name
}


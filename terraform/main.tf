provider "aws" {
  region = "eu-north-1"
}

# Buscar o security group existente
data "aws_security_group" "existing_ssh" {
  filter {
    name   = "group-name"
    values = ["allow_ssh"]
  }

  filter {
    name   = "vpc-id"
    values = ["vpc-020741d6f0bbd3b0d"] # Substitua pelo ID da sua VPC
  }
}

resource "aws_instance" "my_instance" {
  ami           = "ami-042b4708b1d05f512"
  instance_type = "t3.micro"
  key_name      = "my-key_pair"

  # Usar o security group existente
  vpc_security_group_ids = [data.aws_security_group.existing_ssh.id]

  tags = {
    Name = "k3s-ec2-machine"
  }
}

output "ec2_public_ip" {
  value       = aws_instance.my_instance.public_ip
  description = "IP público da instância EC2"
}
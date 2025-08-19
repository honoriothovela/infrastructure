provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-042b4708b1d05f512"
  instance_type = "t3.micro"
  key_name      = "my-key_pair"

  tags = {
    Name = "k3s-ec2-machine"
  }
}

output "ec2_public_ip" {
  value       = aws_instance.my_instance.public_ip
  description = "IP público da instância EC2"
}
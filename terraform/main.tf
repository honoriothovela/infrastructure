provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "k3s_server" {
  ami           = "ami-042b4708b1d05f512"
  instance_type = "t3.micro"
  key_name      = "my-key_pair" # substitua pelo nome da sua key pair na AWS

  tags = {
    Name = "k3s-ec2-machine"
  }
}

output "instance_public_ip" {
  value       = aws_instance.k3s_server.public_ip
  description = "IP público da instância EC2"
}
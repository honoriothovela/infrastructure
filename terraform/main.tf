provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-042b4708b1d05f512"  # Ubuntu 22.04 em eu-north-1
  instance_type = "t3.micro"
  key_name      = "my-key_pair"

  # Adicionando security group para permitir SSH
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "k3s-ec2-machine"
  }
}

# Security group para permitir SSH
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

output "ec2_public_ip" {
  value       = aws_instance.my_instance.public_ip
  description = "IP público da instância EC2"
  sensitive   = false  # Garantir que não seja marcado como sensitive
}
provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-042b4708b1d05f512"
  instance_type = "t3.micro"
  tags = {
    Name = "k3s-ec2-machine"
  }
}


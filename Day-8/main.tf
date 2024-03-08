provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "my_instance" {
  ami = "ami-0d18e50ca22537278"
  instance_type = "t2.micro"
  key_name = "vault_key"
  tags = {
    Name = "TF"
  }
}


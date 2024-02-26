//basic terraform file to create an ec2 instance with os as ubuntu and type as t2.micro
provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "basic_example" {
  ami = "ami-0e5f882be1900e43b"
  instance_type = "t2.micro"
  key_name = "frontend_dev1"
}
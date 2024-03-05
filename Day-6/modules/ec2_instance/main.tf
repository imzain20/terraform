provider "aws" {
  region = "eu-west-2"
}

variable "ami" {
  description = "ami value"
}

variable "instance_type" {
  description = "instance type value"
}

resource "aws_instance" "example" {
  ami = var.ami
  instance_type = var.instance_type
}
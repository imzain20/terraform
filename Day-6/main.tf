provider "aws" {
  region = "eu-west-2"
}

variable "ami" {
  description = "ami value"
}

variable "instance_type" {
  description = "instance type value"
  type = map(string)

  default = {
    "development"   = "t2.micro"
    "production"  = "t2.medium"
  }
}

resource "aws_instance" "example" {
  ami = var.ami
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
}
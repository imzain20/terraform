//.tf file to make EC2 instance with the use of variables

provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "tf-1" {
    ami = var.ami_variable
    instance_type = var.instance_type_variable   
}
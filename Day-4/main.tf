provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "tf-1" {
  ami =  "ami-0e5f882be1900e43b"
  instance_type = "t2.micro"
}

//s3 bucket resource to secure the state file
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-terraform-bucket"  
}

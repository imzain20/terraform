terraform {
  backend "s3" {
    bucket = "my-terraform-bucket"
    region = "us-east-1"
    key = "terraform.tfstate"
  }
}
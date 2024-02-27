//.tf file to make 3 instances of type t2 micro in 3 regions.
provider "aws" {
  alias = "eu-west-1"
  region = "eu-west-1"
}

provider "aws" {
  alias = "eu-west-2"
  region = "eu-west-2"
}

provider "aws" {
  alias = "eu-west-3"
  region = "eu-west-3"
}

resource "aws_instance" "ins-1" {
  ami = "ami-0905a3c97561e0b69"
  instance_type = "t2.micro"
  provider = aws.eu-west-1
  //key_name = ""
}

resource "aws_instance" "ins-2" {
  instance_type = "t2.micro"
  ami = "ami-0e5f882be1900e43b"
  provider = aws.eu-west-2
  //key_name = ""
}

resource "aws_instance" "ins-3" {
  instance_type = "t2.micro"
  ami = "ami-01d21b7be69801c2f"
  provider = aws.eu-west-3  
  //key_name = ""
}
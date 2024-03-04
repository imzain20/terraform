//.tf file to create a VPC, a key_pair for ssh, a public subnet, an internet gateway, a route table, an ec2 instance associated with that public subnet, some security rules and use of provisioners to install and enable nginx on the ec2 instance.

provider "aws" {
  region = "eu-west-2"
}

variable "cidr" {
  default = "10.0.0.0/16"
}

resource "aws_key_pair" "example" {
  key_name = "terraform_instance_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_vpc" "ec2_vpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.ec2_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ec2_vpc.id
}

resource "aws_route_table" "R1" {
  vpc_id = aws_vpc.ec2_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_security_group" "tf-sg" {
  name = "tf-sg"
  vpc_id = aws_vpc.ec2_vpc.id
  
  ingress {
    description = "HTTP from VPC"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-sg"
  }
}

resource "aws_instance" "server" {
   ami = "ami-0e5f882be1900e43b"
   instance_type = "t2.micro"
   key_name = aws_key_pair.example.key_name
   vpc_security_group_ids = [aws_security_group.tf-sg.id]
   subnet_id = aws_subnet.sub1.id
   associate_public_ip_address = true

    connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

    # Local-exec provisioner to run a command on the local machine
    provisioner "local-exec" {
    command = "echo 'This is a local provisioner'"
   }

    # Remote-exec provisioner to run commands on the instance via SSH
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }
}
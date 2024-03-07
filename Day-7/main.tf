provider "aws" {
  region = "eu-west-2"
}

provider "vault" {
  address = "ip-address:8200" //replace ip-address with your vault hosted ip address
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = ""      //add your role-id
      secret_id = ""     //add your-secret-id
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "kv" // change it according to your mount
  name  = "example" // change it according to your secret
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0e5f882be1900e43b"
  instance_type = "t2.micro"

  tags = {
    Secret = data.vault_kv_secret_v2.example    //to get the key-value pair
  }
}
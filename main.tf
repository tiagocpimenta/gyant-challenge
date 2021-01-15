terraform {
 /* backend "remote" {   #access to remote Terraform Cloud
   organization = "tiagocpimenta"
   workspaces {
     name = "desktop-tutorial"
  }
 }*/
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}


provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_instance" "gyant-instance" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"
}

resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.gyant-instance.id
}


#Define Output
output "ip" {
  value = aws_eip.ip.public_ip
}

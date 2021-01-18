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

# create the VPC
resource "aws_vpc" "My_VPC" {
  cidr_block           = var.vpcCIDRblock
  instance_tenancy     = var.instanceTenancy 
  enable_dns_support   = var.dnsSupport 
  enable_dns_hostnames = var.dnsHostNames
tags = {
    Name = "My VPC"
}
} # end resource

# Create the Security Group
resource "aws_security_group" "GYANT_VPC_Security_Group" {
  name         = "GYANT VPC Security Group"
  description  = "GYANT APP VPC Security Group"
  vpc_id       = aws_vpc.My_VPC.id
  
  # allow ingress of port 22 SSH
  ingress {
    description = "SSH from VPC"  
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ingressCIDRblock  
  } 
   # allow ingress of port 80 HTTP
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.ingressCIDRblock 
  } 
   # allow ingress of port 443 HTTTPS
  ingress {
    description = "TLS from VPC" 
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.ingressCIDRblock  
  } 
   # allow ingress of port 3000
  ingress {
    description = "APP port from VPC"   
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = var.ingressCIDRblock
  } 
  
  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
   Name = "GYANT VPC Security Group"
   Description = "GYANT VPC Security Group"
}
} # end resource


#EC2 Create a key pair  - connect EC2 instance SSH
resource "aws_key_pair" "deployer" {
  key_name   = "deployer"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7SWUpcEiDsO14hzDck5V4MD/wyEqVyt5H4YDGuVbd1cophLOQLendCmyQ3osyKe9R2YfcIGPoIOHPSo2CiOdGw1hNjvogoOQuQXOMJZiOh3jHEEZDWzQkgAd22cW44yWX2YzoiiTZtQG88vFf+s2weUA+cb/UNu8Z7aVxatVsJFNoTu3QrusYuDobO96h9fBnFtOGVvY0w6+GEq+YbTekURe26/REjhYLsBGqV3wgxoPaki1Q/wl0qF9eK0DOcbGeKVqSembnWfr0KdDJUEqp5It8zC20ebMZcar/BFsnFm33Dwy51pKBS/ne73avjob5AyTcShB2/9RpUNhNqnpWVTi9la84qGsWrhiSZACcYlpJY0KRxigwDHYgwPpVkZmA/eK0JvUUIL/FEuiaCr/BMQLUF1LtMgt8S6YwclaGEivoYrD94cDnEKUX83E40XCwaRhi20sdtlmWBpyCsFEbYTKDRCJKNt3A33cQicR1OnqyDXjbd7qjupSJk0cEQZ0= tpimenta@Administrators-iMac-3.local"
}

resource "aws_eip" "instance" {
  vpc      = true
  instance = aws_instance.gyant-instance.id
}



resource "aws_instance" "gyant-instance" {
  ami           = "ami-0e80a462ede03e653"
  instance_type = "t2.micro"
  key_name = "deployer"
  tags = {
    Name = "GYANT- App"
  }
}
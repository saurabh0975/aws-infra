provider "aws" {
    access_key = "ACCESS_KEY_HERE"
    secret_key = "SECRET_KEY_HERE"
    region = "region-name"
  
}
resource "aws_vpc" "vpc1" {
    cidr_block = "10.0.0.0/22"
    instance_tenancy = "default"
    assign_generated_ipv6_cidr_block = true
    
    tags = {
      "Name" = "vpc1"
    }
  
}
resource "aws_subnet" "sn1" {
    vpc_id = aws_vpc.vpc1.id
    cidr_block = "10.0.0.0/24"
  
  tags = {
    "Name" = "sn1"
  }
}
resource "aws_subnet" "sn2" {
    vpc_id = aws_vpc.vpc1.id
    cidr_block = "10.0.0.1/24"
  
  tags = {
    "Name" = "sn2"
  }
}
resource "aws_subnet" "sn3" {
    vpc_id = aws_vpc.vpc1.id
    cidr_block = "10.0.2.0/24"
  
  tags = {
    "Name" = "sn3"
  }
}
resource "aws_subnet" "sn4" {
    vpc_id = aws_vpc.vpc1.id
    cidr_block = "10.0.3.0/24"
  
  tags = {
    "Name" = "sn4"
  }
}
resource "aws_internet_gateway" "igw1" {
    vpc_id = aws_vpc.vpc1.id
    
    tags = {
      "Name" = "igw1"
    }
  
}
resource "aws_egress_only_internet_gateway" "egw1" {
    vpc_id = aws_vpc.vpc1.id

    tags = {
      "Name" = "egw1"
    }
  
}
resource "aws_instance" "i1" {
    ami  ="ami-0c1a7f89451184c8b"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.sn1.id
    tags = {
      "Name" = "i1"
    }
  
}
resource "aws_eip" "eip1" {
  instance = aws_instance.i1.id

vpc = true
}
resource "aws_s3_bucket" "bucket1" {
  bucket = "thisisuniquebucker3674"
  acl = "private"
  tags = {
    "Name" = "bucket1"
    enviornment = "Dev"
  }
  
}
resource "aws_iam_user" "user1" {
  name = "user1"
  path = "/"
  tags = {
    "Name" = "user1"
  }
  
}
resource "aws_route_table" "RT1" {
  vpc_id = aws_vpc.vpc1.id

  route = []

  tags = {
    Name = "RT1"
  }
}
resource "aws_route_table_association" "RTA1" {
  subnet_id      = aws_subnet.sn2.id
  route_table_id = aws_route_table.RT1.id
}
resource "aws_route_table_association" "RTA2" {
  gateway_id     = aws_internet_gateway.igw1.id
  route_table_id = aws_route_table.RT1.id
}

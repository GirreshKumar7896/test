provider "aws" {
  region = "us-east-1"
}
variable "vpc_cidr" {
    description = "cidr of vpc" 
}
variable "subnet1_cidr" {
    description = "cidr of subnet 1" 
}
variable "subnet2_cidr" {
    description = "cidr of subnet 2" 
}
resource "aws_vpc" "dev-vpc" {
    cidr_block = var.vpc_cidr
    tags = {
     Name: "dev-vpc"
     vpc_env: "dev"
    }
}
resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.dev-vpc.id
    cidr_block = var.subnet1_cidr
    availability_zone = "us-east-1a"
    tags = {
     Name: "subnet-1"
    }
}
data "aws_vpc" "existing_vpc" {
    default = true
}
resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = var.subnet2_cidr
    availability_zone = "us-east-1a"
    tags = {
     Name: "subnet-2"
    }
}

output "vpc-id" {
    value = "aws_vpc.dev-vpc.id"
}
output "subnetpc-id" {
    value = "aws_subnet.dev-subnet-1.id"
}
output "Subnet-id" {
    value = "aws_subnet.dev-subnet-2.id"
}
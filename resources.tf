provider "aws" {
  region = "us-east-1"  # Change to your desired AWS region
}

resource "aws_vpc" "default_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "default_gw" {
  vpc_id = aws_vpc.default_vpc.id
}

resource "aws_route_table" "default_rt" {
  vpc_id = aws_vpc.default_vpc.id
}

resource "aws_instance" "ec2server" {
  ami           = "ami-xxxxxxxxx"  # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"
  subnet_id     = aws_vpc.default_vpc.id  # Ensure a subnet is created or used
}

@"
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Creat EC2
resource "aws_ec2" "My_webserver1" {
    cidr_block = 10.0.0.0/16
    ami           = "ami-05b10e08d247fb927 (64-bit (x86), uefi-preferred) / ami-0f37c4a1ba152af46 (64-bit (Arm), uefi)" 
    instance_type = "t2.micro"
    subnet_id     = aws_vpc.default_vpc.id 
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

# Security Group for EC2
resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "web_server" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Terraform-Web-Server"
  }
}

# RDS Database
resource "aws_db_instance" "rds" {
  allocated_storage = 20
  engine           = "mysql"
  instance_class   = "db.t2.micro"
  db_name         = "mydatabase"
  username        = "admin"
  password        = "TerraformPass123!"
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
}

# Output Public IP
output "ec2_public_ip" {
  value = aws_instance.web_server.public_ip
}
"@ | Out-File -Encoding utf8 main.tf


# Providers
provider "aws" {
  version = "~> 2.0"
  access_key = "access_key"
  secret_key = "secret_key"
  region = "us-east-1"
}

# VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "techtest"
  cidr = "10.0.0.0/16"
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_dns_hostnames = "true"
  enable_dns_support = "true"
  azs = ["us-east-1a","us-east-1b","us-east-1c","us-east-1d","us-east-1e"]
}

# Security Group
    resource "aws_security_group" "nodes-sg" {
  name        = "test-nodes-sg"
  description = "Slave Nodes Security Group"
  vpc_id      = "${module.vpc.vpc_id}"

  tags = {
    Name = "test-nodes-sg"
  }
}

# Rules Out
resource "aws_security_group_rule" "nodes-sg-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.nodes-sg.id}"
}

# Rule IN
resource "aws_security_group_rule" "nodes-sg-allow-ssh"{
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.nodes-sg.id}"
}

# Rule IN - Port APP PROD
resource "aws_security_group_rule" "nodes-sg-allow-prod"{
  type              = "ingress"
  from_port         = 5000
  to_port           = 5000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.nodes-sg.id}"
}

# Rule IN - Port APP DEV
resource "aws_security_group_rule" "nodes-sg-allow-dev"{
  type              = "ingress"
  from_port         = 6000
  to_port           = 6000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.nodes-sg.id}"
}

# Create Machine
resource "aws_instance" "techtest" {
  ami = "ami-0cfee17793b08a293"
  instance_type = "t2.micro"
  key_name = "fernando"
  vpc_security_group_ids = ["${aws_security_group.nodes-sg.id}"]
  associate_public_ip_address = true

  tags = {
    Name = "techtest"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = "10"
  }

  user_data = "${file("docker.sh")}"
  availability_zone = "us-east-1a"
  subnet_id = "${element(module.vpc.public_subnets,0)}"
}
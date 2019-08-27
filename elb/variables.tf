variable "region" {
  description = "AWS Region"
  default = "us-east-1"
}

variable "key_path" {
  description = "Public key path"
  default = "/home/ubuntu/.ssh/id_rsa.pub"
}

variable "ami" {
  description = "AMI"
  default = "ami-0cfee17793b08a293" // Amazon Linux
}

variable "instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
}
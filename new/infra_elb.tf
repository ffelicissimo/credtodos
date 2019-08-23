provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {}

resource "aws_security_group" "instance" {
  name = "go-api-instance"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "example" {
  image_id        = "ami-58d7e821"
  instance_type   = "t2.micro"
  key_name        = "fernando"
  security_groups = ["${aws_security_group.instanced.id}"]
  user_data       = "${file("setup.sh")}"

  lifecycle {
    create_before_destroy = true
  }
}
#Criando Elastic

resource "aws_autoscaling_group" "example" {
  launch_configuration = "${aws_launch_configuration.example.id}"
  load_balancers       = ["${aws_elb.example.name}"]
  availability_zones   = ["us-east-1", "us-east-2"]
  min_size             = 2
  max_size             = 5

  tag {
    key                 = "Name"
    value               = "terraform-go-api"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "elb" {
  name = "terraform-go-api"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "example" {
  name               = "terraform-go-api"
  availability_zones = ["eu-west-1b", "eu-west-1a"]
  security_groups    = [aws_security_group.elb.id]

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = 80
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }
}

output "elb_dns_name" {
  value = "${aws_elb.example.dns_name}"
}
provider "aws" {
  region = "ap-south-1" 
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0f918f7e67a3323f0"  
  instance_type = "t2.micro"
  key_name      = "gym-key"               

  vpc_security_group_ids = [aws_security_group.my_sg.id]

  root_block_device {
    volume_size = 20  # Set disk size to 20 GB
    volume_type = "gp2"
  }

  associate_public_ip_address = true

  tags = {
    Name = "Gym-app"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y docker.io
              sudo systemctl start docker
              sudo systemctl enable docker
              EOF
}

resource "aws_security_group" "my_sg" {
  name        = "my-ec2-sg"
  description = "Allow HTTP, SSH, Flask, Prometheus, Grafana, Kubernetes"

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

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-ec2-sg"
  }
}


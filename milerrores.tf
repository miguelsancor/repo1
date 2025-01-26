provider "aws" {
  region = "us-east-1"
}

# Error: AWS Security Group with open ingress to all ports
resource "aws_security_group" "insecure_sg" {
  name        = "insecure_sg"
  description = "Security group with open ingress"

  ingress {
    from_port   = 0
    to_port     = 65535
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

# Error: AWS S3 bucket without encryption
resource "aws_s3_bucket" "unencrypted_bucket" {
  bucket = "my-insecure-bucket"
  acl    = "public-read"
}

# Error: Unsecured EC2 instance with SSH access open to the world
resource "aws_instance" "insecure_instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  security_groups = [aws_security_group.insecure_sg.name]

  tags = {
    Name = "InsecureInstance"
  }
}

# Error: RDS instance with public access
resource "aws_db_instance" "insecure_rds" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = "mydatabase"
  username             = "admin"
  password             = "password123" # Weak password
  publicly_accessible  = true
  skip_final_snapshot  = true
}

# Error: IAM policy with overly permissive actions
resource "aws_iam_policy" "insecure_policy" {
  name        = "insecure_policy"
  description = "Policy with overly permissive actions"

  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOT
}

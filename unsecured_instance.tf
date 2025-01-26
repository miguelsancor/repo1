provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "unsecured_instance" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  tags = {
    Name = "Unsecured Instance"
  }

  user_data = <<EOF
#!/bin/bash
echo "root:password123" | chpasswd # Vulnerabilidad: Contraseña en texto plano
EOF
}

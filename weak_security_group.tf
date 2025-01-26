resource "aws_security_group" "weak_sg" {
  name        = "insecure-security-group"
  description = "Allows all traffic"
  vpc_id      = "vpc-12345678"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Vulnerabilidad: Permite tráfico desde cualquier IP
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Vulnerabilidad: Permite tráfico saliente a cualquier IP
  }

  tags = {
    Name = "Weak Security Group"
  }
}

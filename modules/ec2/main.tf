resource "aws_instance" "main" {
  ami           = "ami-0aff18ec83b712f05" # Example AMI ID
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.main.id]
  key_name = var.key_name
}

resource "aws_security_group" "main" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_db_instance" "main" {
  identifier = "example-db-instance"
  engine     = "postgres"
  instance_class = "db.t3.micro"
  storage_type = "gp2"
  allocated_storage = 20
  publicly_accessible    = true
  username = var.db_username
  password = var.db_password
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.main.id]
  multi_az = false
  skip_final_snapshot = true

}

resource "aws_db_subnet_group" "main" {
  name       = "example-db-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "main" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = 5432
    to_port     = 5432
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

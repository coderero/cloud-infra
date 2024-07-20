resource "aws_msk_cluster" "main" {
  cluster_name = "example-kafka-cluster"
  kafka_version = "2.8.1"
  number_of_broker_nodes = 4
  broker_node_group_info {
    instance_type   = "kafka.t3.small"
    client_subnets  = var.subnet_ids
    security_groups = [aws_security_group.main.id]
    storage_info {
        ebs_storage_info {
            volume_size = 20
        }
    }
  }
  enhanced_monitoring = "DEFAULT"
}

resource "aws_security_group" "main" {
  vpc_id = var.vpc_id
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

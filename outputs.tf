output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "kafka_cluster_id" {
  value = module.kafka.kafka_cluster_id
}

output "kubernetes_cluster_name" {
  value = module.kubernetes.cluster_name
}

output "database_endpoint" {
  value = module.database.db_endpoint
}

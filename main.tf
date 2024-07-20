// Setting up the the provider with custom version
terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0" // Setting up the version
        }
    }
}

provider "aws" {
  region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_key_pair" "instance_key" {
    key_name = "instance_key"
    public_key = file("${path.module}/id_rsa.pub")
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "ec2" {
  source = "./modules/ec2"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnets[0]
  key_name = aws_key_pair.instance_key.key_name
}

module "kafka" {
  source = "./modules/kafka"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
}

module "kubernetes" {
  source = "./modules/kubernetes"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
}

module "database" {
  source = "./modules/database"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  db_username = var.db_username
  db_password = var.db_password
}
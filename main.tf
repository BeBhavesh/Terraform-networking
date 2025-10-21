# main.tf
module "network" {
  source = "./modules/vpc"
  aws_region = "us-east-1"
    vpc_cidr          = var.vpc_cidr
    public_subnets    = var.public_subnets
    private_subnets   = var.private_subnets
    availability_zones = var.availability_zones

}
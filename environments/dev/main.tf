provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  name = "${var.project_name}-${var.environment}"
  azs  = slice(data.aws_availability_zones.available.names, 0, 2)
}

module "vpc" {
  source = "../../modules/vpc"

  name                = local.name
  vpc_cidr            = var.vpc_cidr
  azs                 = local.azs
  public_subnet_cidrs = [cidrsubnet(var.vpc_cidr, 8, 1), cidrsubnet(var.vpc_cidr, 8, 2)]
}

module "web" {
  source = "../../modules/web"

  name          = local.name
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.public_subnet_ids
  instance_type = var.instance_type
}

module "monitoring" {
  source = "../../modules/monitoring"

  name                    = local.name
  alert_email             = var.alert_email
  asg_name                = module.web.asg_name
  alb_arn_suffix          = module.web.alb_arn_suffix
  target_group_arn_suffix = module.web.target_group_arn_suffix
}

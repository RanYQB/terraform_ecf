terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.37.0"
    }
  }

  required_version = ">= 1.2.0"
}

locals {
  name   = "pyspark-cluster"
  region = "eu-west-3"

  vpc_cidr = "10.123.0.0/16"
  azs      = ["eu-west-3a", "eu-west-3b"]

  public_subnets  = ["10.123.1.0/24", "10.123.2.0/24"]
  private_subnets = ["10.123.3.0/24", "10.123.4.0/24"]
  intra_subnets   = ["10.123.5.0/24", "10.123.6.0/24"]

  tags = {
    Example = local.name
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets
  intra_subnets   = local.intra_subnets

  enable_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}
#########################################
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.2.1"

  cluster_name                   = local.name
  cluster_endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent    = true
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = ["m5.large"]
    attach_cluster_primary_security_group = true
  }

  eks_managed_node_groups = {
    pyspark_cluster = {
      name            = "pyspark-eks-mng"
      use_name_prefix = true
      min_size     = 1
      max_size     = 2
      desired_size = 1

      capacity_type        = "SPOT"
      instance_types       = ["m5.large"]

      description = "EKS managed node group - Pyspark Cluster"

      tags = {
        ExtraTag = "Pyspark Cluster"
      }
    }
  }
  
  tags = local.tags
}

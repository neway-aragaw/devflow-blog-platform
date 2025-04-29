module "vpc" {
  source        = "../../modules/vpc"
  cidr_block    = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  azs           = ["us-east-2a", "us-east-2b"]
}

module "iam" {
  source = "../../modules/iam"
  cluster_role_name = "devflow-dev-cluster-role"
  node_role_name    = "devflow-dev-node-role"
}

module "eks" {
  source            = "../../modules/eks"
  cluster_name      = "devflow-dev-eks-cluster"
  cluster_version   = "1.29"
  
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.public_subnets
  
  cluster_role_arn  = module.iam.eks_cluster_role_arn
  node_role_arn     = module.iam.eks_node_role_arn
  
  node_desired_size = 2
  node_min_size     = 1
  node_max_size     = 3
  node_instance_types = ["t3.medium"]
}

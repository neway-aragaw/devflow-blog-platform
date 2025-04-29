output "cluster_name" {
  value = module.eks.eks_cluster_name
}

output "cluster_endpoint" {
  value = module.eks.eks_cluster_endpoint
}

variable "cluster_name" {}
variable "cluster_version" { default = "1.29" }
variable "vpc_id" {}
variable "subnet_ids" {}

variable "cluster_role_arn" {}
variable "node_role_arn" {}

variable "node_desired_size" { default = 2 }
variable "node_min_size" { default = 1 }
variable "node_max_size" { default = 3 }
variable "node_instance_types" { default = ["t3.medium"] }

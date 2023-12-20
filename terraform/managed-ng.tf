module "eks_managed_node_group" {
  source = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"

  name            = "managed-ng"
  cluster_name    = "demo-eks-cluster"
  cluster_version = "1.24"

  subnet_ids = module.dev-vpc.private_subnets


  cluster_primary_security_group_id = module.eks.cluster_primary_security_group_id
  vpc_security_group_ids            = [module.eks.node_security_group_id]

  min_size     = 1
  max_size     = 2
  desired_size = 1

  instance_types = ["t2.micro"]
  capacity_type  = "SPOT"

  labels = {
    Environment = "demo-app"
  }

  taints = {
    dedicated = {
      key    = "managed"
      value  = "demo-app"
      effect = "NO_SCHEDULE"
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
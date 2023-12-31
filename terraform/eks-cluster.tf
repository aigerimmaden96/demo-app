module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 19.21.0"
    cluster_name = "demo-eks-cluster"
    cluster_version = "1.24"

    cluster_endpoint_public_access  = true

    vpc_id = module.dev-vpc.vpc_id
    subnet_ids = module.dev-vpc.private_subnets

    tags = {
        environment = "development"
        application = "demo-app"
    }

    node_security_group_tags = {
        "kubernetes.io/cluster/demo-eks-cluster" = null
    }

    eks_managed_node_groups = {
        dev = {
            min_size = 1
            max_size = 3
            desired_size = 2

            instance_types = ["t2.micro"]
        }
    }
}
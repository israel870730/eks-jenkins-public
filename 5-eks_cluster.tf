module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.19.0"

  cluster_name    = "new-demo"
  cluster_version = "1.25"
  enable_irsa = true

  cluster_endpoint_private_access = false
  cluster_endpoint_public_access  = true

  # EKS Add-ons
  cluster_addons = {
    # aws-ebs-csi-driver = {
    #   most_recent = true
    # }
    # vpc-cni = {
    #   most_recent = true
    # }
    amazon-cloudwatch-observability = {
      most_recent = true
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_group_defaults = {
    disk_size = 50
  }

  eks_managed_node_groups = {
    ON_DEMAND = {
      desired_size = 2
      min_size     = 2
      max_size     = 10
      node_group_name = "ON_DEMAND"
      name = "ON_DEMAND"

      labels = {
        role = "general"
      }

      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"
    }
  }

    manage_aws_auth_configmap = true
    aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::114712064551:role/aws-reserved/sso.amazonaws.com/eu-west-2/AWSReservedSSO_AWSAdministratorAccess_e1c02011dbc6c63b"
      username = "AWSReservedSSO_AWSAdministratorAccess_e1c02011dbc6c63b/israel.garcia"
      groups   = ["system:masters"]
    },
  ]

  tags = {
    Environment = "staging"
  }
}


############# kubernetes_addons #############
module "kubernetes_addons" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.32.1"

  eks_cluster_id       = module.eks.cluster_name
  eks_cluster_endpoint = module.eks.cluster_endpoint
  eks_oidc_provider    = module.eks.oidc_provider
  eks_cluster_version  = module.eks.cluster_version

  # Self-managed Add-ons
  enable_metrics_server = true
  enable_cluster_autoscaler = true
  enable_aws_load_balancer_controller = true
  
  enable_aws_efs_csi_driver = true
  aws_efs_csi_driver_helm_config = {
    description = "The AWS EFS CSI driver Helm chart deployment configuration"
    repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
    version    = "2.4.0"
    namespace  = "kube-system"
  }

  # enable_aws_cloudwatch_metrics = true
  # aws_cloudwatch_metrics_helm_config = {
  #   description = "The AWS CloudWatch Metrics Helm chart deployment configuration"
  #   namespace  = "kube-system"
  # }

  # enable_aws_for_fluentbit = true
  # aws_for_fluentbit_helm_config = {
  #   description = "The Fluentbit Helm chart deployment configuration"
  #   namespace  = "kube-system"
  # }
  
  #enable_kube_prometheus_stack = true
  #kube_prometheus_stack_helm_config = {
  #  description = "The Prometheus Stack Helm chart deployment configuration"
  #  namespace  = "prometheus-stack"
  #}

  #enable_kubernetes_dashboard = true
  #kubernetes_dashboard_helm_config = {
  #  description = "The Kubernetes Dashboard Helm chart deployment configuration"
  #  namespace  = "kube-system"
  #}

}
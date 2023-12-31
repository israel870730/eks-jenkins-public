# variable "cluster_name" {
#   description = "Name of the EKS cluster"
#   type        = string
#   default     = ""
# }

# variable "cluster_version" {
#   description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.27`)"
#   type        = string
#   default     = null
# }

# variable "enable_irsa" {
#   description = "Determines whether to create an OpenID Connect Provider for EKS to enable IRSA"
#   type        = bool
#   default     = true
# }

# variable "cluster_enabled_log_types" {
#   description = "A list of the desired control plane logs to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
#   type        = list(string)
#   default     = ["audit", "api", "authenticator", "controllerManager", "scheduler"]
# }

# variable "cluster_endpoint_public_access" {
#   description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
#   type        = bool
#   default     = true
# }

# variable "cluster_endpoint_private_access" {
#   description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
#   type        = bool
#   default     = false
# }

# variable "aws_auth_roles" {
#   description = "List of role maps to add to the aws-auth configmap"
#   type        = list(any)
#   default     = []
# }

variable "tags" {
description = "Tags for infrastructure resources."
type        = map
}
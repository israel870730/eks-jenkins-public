# eks-jenkins
Private repository to create a EKS cluster.

This repo is for create a eks cluster using bluprint module terraform

# First export the profile.
export AWS_PROFILE=poc

# If you want also can export the region
export AWS_DEFAULT_REGION=us-east-1

# Update the .kube/config file to acces inside the cluster
aws eks update-kubeconfig --region us-west-1 --name demo --profile poc
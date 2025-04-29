#!/bin/bash

# -----------------------------------------
# Deploy only Frontend to EKS
# Cluster Region: us-east-1
# Author: Neway Aragaw
# -----------------------------------------

# 1. Set Variables
CLUSTER_NAME="eks-acg"
REGION="us-east-1"
NAMESPACE="devflow"
FRONTEND_HELM_DIR="$(dirname "$0")/../frontend"
VALUES_FILE="values-dev.yaml"  # <-- Change if you want prod/staging

echo "🛠  Starting frontend deployment to EKS Cluster: $CLUSTER_NAME in $REGION region"

# 2. Update kubeconfig to point to EKS Cluster
echo "🔗 Updating kubeconfig..."
aws eks --region $REGION update-kubeconfig --name $CLUSTER_NAME

# 3. Create Namespace if it doesn't exist
if kubectl get namespace $NAMESPACE > /dev/null 2>&1; then
    echo "✅ Namespace '$NAMESPACE' already exists."
else
    echo "📦 Creating namespace: $NAMESPACE"
    kubectl create namespace $NAMESPACE
fi

# 4. Deploy Frontend using Helm
echo "🚀 Deploying Frontend Helm Chart..."
helm upgrade --install frontend-release $FRONTEND_HELM_DIR -f $FRONTEND_HELM_DIR/$VALUES_FILE -n $NAMESPACE

# 5. Get all services and pods
echo "📡 Getting all services and pods..."
kubectl get svc -n $NAMESPACE
kubectl get pods -n $NAMESPACE

# 6. Reminder to check External IP
echo "🌎 Deployment triggered! Check your frontend LoadBalancer EXTERNAL-IP using:"
echo "kubectl get svc -n $NAMESPACE"

echo "✅ Frontend deployment script finished successfully!"

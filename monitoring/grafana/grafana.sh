#!/bin/bash

echo "📦 Deploying Grafana to the 'monitoring' namespace..."

# Step 1: Make sure namespace exists (ignore error if it already does)
kubectl create namespace monitoring 2>/dev/null || echo "Namespace 'monitoring' already exists ✅"

# Step 2: Apply Grafana configs
kubectl apply -f datasource.yml -n monitoring
kubectl apply -f grafana-deployment.yaml -n monitoring
kubectl apply -f grafana-service.yaml -n monitoring

# Step 3: Wait for the pod to be ready
echo "⏳ Waiting for Grafana pod to be ready..."
kubectl wait --for=condition=ready pod -l app=grafana -n monitoring --timeout=90s

# Step 4: Port forward
echo "🚀 Port forwarding Grafana to http://localhost:3000 ..."
kubectl port-forward svc/grafana 3000:3000 -n monitoring

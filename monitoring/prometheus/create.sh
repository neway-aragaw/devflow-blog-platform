# 1. Create monitoring namespace
kubectl create namespace monitoring

# 2. Deploy Prometheus (apply all Prometheus YAMLs)
kubectl apply -f configmap-prometheus.yaml -n monitoring
kubectl apply -f prometheus-deployment.yaml -n monitoring
kubectl apply -f prometheus-service.yaml -n monitoring


# 3. Verify Prometheus pod
kubectl get pods -n monitoring
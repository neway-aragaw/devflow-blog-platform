#!/bin/bash

# Define services
services=("frontend" "backend")

# Create helm directory if it doesn't exist
mkdir -p helm

# Loop through services
for service in "${services[@]}"; do
  mkdir -p helm/$service/templates

  # Create Chart.yaml
  cat <<EOF > helm/$service/Chart.yaml
apiVersion: v2
name: $service
description: A Helm chart for $service
type: application
version: 0.1.0
appVersion: "1.0"
EOF

  # Create values.yaml
  cat <<EOF > helm/$service/values.yaml
replicaCount: 1

image:
  repository: your-docker-repo/$service
  tag: latest
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 80

resources: {}

nodeSelector: {}

tolerations: []

affinity: {}
EOF

  # Create templates/deployment.yaml
  cat <<EOF > helm/$service/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-$service
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ .Release.Name }}-$service
  template:
    metadata:
      labels:
        app: {{ .Release.Name }}-$service
    spec:
      containers:
        - name: $service
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          ports:
            - containerPort: {{ .Values.service.port }}
EOF

  # Create templates/service.yaml
  cat <<EOF > helm/$service/templates/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ .Release.Name }}-$service
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: {{ .Values.service.port }}
  selector:
    app: {{ .Release.Name }}-$service
EOF

  # Create environment-specific values
  for env in dev staging prod; do
    cat <<EOF > helm/$service/values-$env.yaml
replicaCount: 1

image:
  repository: your-docker-repo/$service
  tag: $env
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 80
EOF
  done
done

echo "✅ Helm structure and files created for frontend and backend!"

#!/bin/bash

# Create root folder
mkdir -p infra

# Create environment folders
mkdir -p infra/environments/dev
mkdir -p infra/environments/staging
mkdir -p infra/environments/prod

# Create module folders
mkdir -p infra/modules/eks
mkdir -p infra/modules/vpc
mkdir -p infra/modules/iam

# Create Terraform files inside environments
touch infra/environments/dev/main.tf infra/environments/dev/variables.tf infra/environments/dev/outputs.tf
touch infra/environments/staging/main.tf infra/environments/staging/variables.tf infra/environments/staging/outputs.tf
touch infra/environments/prod/main.tf infra/environments/prod/variables.tf infra/environments/prod/outputs.tf

# Create Terraform files inside modules
touch infra/modules/eks/main.tf infra/modules/eks/variables.tf infra/modules/eks/outputs.tf
touch infra/modules/vpc/main.tf infra/modules/vpc/variables.tf infra/modules/vpc/outputs.tf
touch infra/modules/iam/main.tf infra/modules/iam/variables.tf infra/modules/iam/outputs.tf

# Create root-level Terraform files
touch infra/backend.tf
touch infra/provider.tf

echo "✅ Infrastructure folder structure created successfully!"

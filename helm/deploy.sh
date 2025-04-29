# Make sure you are in the helm folder
cd ~/OneDrive/Desktop/FinalProject/devflow-blog-platform/helm

# Install backend
helm upgrade --install backend-dev ./backend --namespace dev --values ./backend/values-dev.yaml

# Install frontend
helm upgrade --install frontend-dev ./frontend --namespace dev --values ./frontend/values-dev.yaml

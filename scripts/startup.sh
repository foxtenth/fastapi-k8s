#!/bin/bash

# 1. Load local image into Kind
echo "🚀 Loading FastAPI image into kind..."
kind load docker-image fastapi-app:v1 --name dev-cluster

# 2. Apply Redis Infrastructure (Secret, Config, PVC)
echo "💾 Applying Redis Infrastructure..."
kubectl apply -f redis-infra.yaml

# 3. Apply Redis Deployment & Service
echo "🗄️ Starting Redis..."
kubectl apply -f redis-deploy.yaml

# 4. Apply FastAPI Deployment & Service
echo "⚡ Starting FastAPI..."
kubectl apply -f fastapi-deploy.yaml

# 5. Wait for pods to be ready
echo "⏳ Waiting for pods to stabilize..."
kubectl wait --for=condition=ready pod -l app=fastapi --timeout=60s

echo "✅ Startup Complete! Run 'kubectl get pods' to verify."

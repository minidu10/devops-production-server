#!/bin/bash

set -e

PROJECT_DIR="/home/minidu/devops-project"

echo "🚀 Starting deployment..."

cd "$PROJECT_DIR"

echo "📥 Pulling latest code..."
git pull origin main

echo "🔍 Validating Python application..."
python3 -m py_compile app/app.py

echo "✅ Python validation passed"

echo "🔄 Restarting application..."
sudo systemctl restart devops-app

echo "⏳ Waiting for application..."
sleep 2

echo "🩺 Running health check..."

if ./scripts/health-check.sh; then
    echo "✅ Deployment successful!"
else
    echo "❌ Deployment failed!"
    exit 1
fi

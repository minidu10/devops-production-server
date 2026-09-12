#!/bin/bash

set -e

echo "🔍 Running preflight checks..."
./scripts/preflight.sh

PROJECT_DIR="/home/minidu/devops-project"

cd "$PROJECT_DIR"

echo "🚀 Starting deployment..."

PREVIOUS_COMMIT=$(git rev-parse HEAD)

echo "📌 Current version: $PREVIOUS_COMMIT"

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
    echo "❌ Health check failed!"
    echo "🔙 Rolling back to $PREVIOUS_COMMIT..."

    git reset --hard "$PREVIOUS_COMMIT"

    sudo systemctl restart devops-app

    sleep 2

    if ./scripts/health-check.sh; then
        echo "✅ Rollback successful!"
    else
        echo "🚨 Rollback failed!"
        exit 1
    fi

    exit 1
fi

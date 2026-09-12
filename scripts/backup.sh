#!/bin/bash

set -e

PROJECT_DIR="/home/minidu/devops-project"
BACKUP_DIR="/var/backups/devops-app"

TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
BACKUP_FILE="$BACKUP_DIR/devops-app-$TIMESTAMP.tar.gz"

echo "💾 Starting backup..."

tar -czf "$BACKUP_FILE" \
    --exclude=".git" \
    --exclude="logs" \
    --exclude="__pycache__" \
    -C "$(dirname "$PROJECT_DIR")" \
    "$(basename "$PROJECT_DIR")"

echo "✅ Backup created:"
echo "$BACKUP_FILE"

echo
echo "📦 Backup size:"
du -h "$BACKUP_FILE"

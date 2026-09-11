#!/bin/bash

URL="http://localhost:8000"

if curl -fs "$URL" > /dev/null; then
    echo "✅ Application is healthy"
    exit 0
else
    echo "❌ Application is DOWN"
    exit 1
fi

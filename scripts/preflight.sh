#!/bin/bash

set -e

echo "======================================"
echo "       DEVOPS PREFLIGHT CHECK"
echo "======================================"

echo
echo "🔍 Checking required commands..."

for cmd in git python3 curl systemctl nginx; do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "   ✅ $cmd"
    else
        echo "   ❌ $cmd missing"
        exit 1
    fi
done

echo
echo "🔍 Checking application..."

if systemctl is-active --quiet devops-app; then
    echo "   ✅ devops-app"
else
    echo "   ❌ devops-app is not running"
    exit 1
fi

echo
echo "🔍 Checking Nginx..."

if systemctl is-active --quiet nginx; then
    echo "   ✅ nginx"
else
    echo "   ❌ nginx is not running"
    exit 1
fi

echo
echo "🔍 Checking application health..."

if curl -fsS http://localhost:8000 >/dev/null; then
    echo "   ✅ Application responding"
else
    echo "   ❌ Application unavailable"
    exit 1
fi

echo
echo "🔍 Checking Nginx..."

if curl -fsS http://localhost >/dev/null; then
    echo "   ✅ Nginx responding"
else
    echo "   ❌ Nginx unavailable"
    exit 1
fi

echo
echo "🔍 Checking firewall..."

if sudo ufw status | grep -q "Status: active"; then
    echo "   ✅ UFW active"
else
    echo "   ❌ UFW inactive"
    exit 1
fi

echo
echo "======================================"
echo "✅ PREFLIGHT CHECK PASSED"
echo "======================================"

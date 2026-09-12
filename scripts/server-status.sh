#!/bin/bash

echo "======================================"
echo "        DEVOPS SERVER STATUS"
echo "======================================"

echo

echo "🔧 Application:"
if systemctl is-active --quiet devops-app; then
    echo "   ✅ devops-app is running"
else
    echo "   ❌ devops-app is DOWN"
fi

echo

echo "🌐 Nginx:"
if systemctl is-active --quiet nginx; then
    echo "   ✅ nginx is running"
else
    echo "   ❌ nginx is DOWN"
fi

echo

echo "🩺 Application Health:"
if curl -fs http://localhost:8000 > /dev/null; then
    echo "   ✅ Python application responding"
else
    echo "   ❌ Python application not responding"
fi

echo

echo "🌍 Nginx Health:"
if curl -fs http://localhost > /dev/null; then
    echo "   ✅ Nginx responding"
else
    echo "   ❌ Nginx not responding"
fi

echo

echo "💾 Disk:"
df -h / | tail -1

echo

echo "🧠 Memory:"
free -h | grep Mem:

echo

echo "⏱️ Uptime:"
uptime

echo

echo "🔌 Listening Ports:"
sudo ss -ltnp | grep -E ':80|:8000'

echo
echo "======================================"

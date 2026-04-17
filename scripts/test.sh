#!/bin/bash

# 1. Start port-forwarding in the background
echo "🔌 Opening tunnel to FastAPI..."
kubectl port-forward service/fastapi-nodeport 30000:8000 > /dev/null 2>&1 &
PID=\$!

# Give the tunnel a second to initialize
sleep 2

# 2. Run Curl Tests
echo "🧪 Testing Root Endpoint..."
curl -s http://localhost:30000/

echo -e "\n🧪 Testing Hits Endpoint..."
curl -s http://localhost:30000/hits

# 3. Kill the port-forwarding process
echo -e "\n🧹 Cleaning up tunnel (PID: \$PID)..."
kill \$PID
echo "Done."

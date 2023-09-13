#!/bin/bash
set -e

echo "Wait for Elasticsearch to start..."
while ! curl -s "http://elasticsearch:9200/_cluster/health" | grep -q green; do
  sleep 1;
done
echo "Elasticsearch started"

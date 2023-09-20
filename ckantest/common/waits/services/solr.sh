#!/bin/bash
set -e

echo "Wait for Solr to start..."
while ! curl -s "http://solr:8983/solr/ckan/admin/ping" | grep -q OK; do
  sleep 1;
done
echo "Solr started"

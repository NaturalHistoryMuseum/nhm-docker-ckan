#!/bin/bash
set -e

echo "Wait for MongoDB to start..."
while ! nc -z mongodb 27017; do
  sleep 1;
done
echo "MongoDB started"

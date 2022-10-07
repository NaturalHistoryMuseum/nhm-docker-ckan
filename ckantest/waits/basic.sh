#!/bin/bash
set -e

bash "${BASH_SOURCE%/*}/services/postgresql.sh"
bash "${BASH_SOURCE%/*}/services/solr.sh"
bash "${BASH_SOURCE%/*}/services/redis.sh"

echo "All services up, running command"

exec "$@"

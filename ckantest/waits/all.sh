#!/bin/bash
set -e

bash "${BASH_SOURCE%/*}/services/postgresql.sh"
bash "${BASH_SOURCE%/*}/services/solr.sh"
bash "${BASH_SOURCE%/*}/services/redis.sh"
bash "${BASH_SOURCE%/*}/services/elasticsearch.sh"
bash "${BASH_SOURCE%/*}/services/mongodb.sh"

echo "Setting DB permissions..."
export PGPASSWORD=${PGPASSWORD:-"password"}
/venv/bin/ckan -c test.ini datastore set-permissions | psql -h db -U ckan
echo "Permissions set"

echo "All services up, running command"

exec "$@"

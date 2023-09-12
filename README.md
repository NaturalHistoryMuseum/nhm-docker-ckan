# nhm-docker-ckan

## ckantest
A docker image which supports installing a CKAN extension and running tests.
The docker image:

- installs basic OS packages
- installs Python 3.8 virtualenv
- installs Node version 15
- installs CKAN version 2.9.5 from the base CKAN repository
- installs `pytest-ckan` (see https://github.com/ckan/ckan/issues/5570)
- installs a set of scripts that can be used as entrypoints to wait for services to begin

The CKAN base is installed in `/base/src/ckan`.

Python3.8 is installed in `/venv` but is available as just `python` (as is `pip`).

### Usage
Start your `Dockerfile` with `FROM naturalhistorymuseum/ckantest:latest` to use this image.

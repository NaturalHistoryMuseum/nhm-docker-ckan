# nhm-docker-ckan

## ckantest
A set of docker images which support installing a CKAN extension and running tests.
The docker image:

- installs basic OS packages
- installs Python 3.8 virtualenv
- installs Node version 15
- installs CKAN from the base CKAN repository
- installs `pytest-ckan` (see https://github.com/ckan/ckan/issues/5570)
- installs a set of scripts that can be used as entrypoints to wait for services to begin

The CKAN base is installed in `/base/src/ckan`.

Python3.8 is installed in `/venv` but is available as just `python` (as is `pip`).

### CKAN Versions
There are two versions of the docker image available, one for CKAN 2.9.x and one for
2.10.x.

### Tags and Usage
Depending on the version of CKAN you want to use, select the appropriate tag:

- `latest` is latest CKAN 2.9.x, currently 2.9.9
- `next` is latest CKAN 2.10.x, currently 2.10.1

To use any of these tags just start your `Dockerfile` with `FROM naturalhistorymuseum/ckantest:<tag>`.


## Building
To build and publish these images do:

1. From the repo root, run `docker build -f ckantest/ckan-<version>/Dockerfile .` where
   `<version>` is the major and minor version of CKAN (either 2.9 or 2.10) you want to
   build.
2. Push using `docker push naturalhistorymuseum/ckantest:<tagname>` where `<tagname>` is
   the tag you'd like to use.

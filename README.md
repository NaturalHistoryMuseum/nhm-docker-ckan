# nhm-docker-ckan

## ckantest

A set of docker images which support installing a CKAN extension and running tests.
The docker image:

- installs basic OS packages
- installs Python 3.8 virtualenv
- installs Node version 15
- installs CKAN from the base CKAN repository
- installs `pytest-ckan` (see https://github.com/ckan/ckan/issues/5570)
- installs a set of scripts that can be used as entrypoints to wait for services to
  begin

The CKAN base is installed in `/base/src/ckan`.

Python3.8 is installed in `/venv` but is available as just `python` (as is `pip`).

### CKAN Versions

There are two versions of the docker image available, one for CKAN 2.9.x and one for
2.10.x.

### Tags and Usage

Depending on the version of CKAN you want to use, select the appropriate tag:

- `latest` is latest CKAN 2.9.x, currently 2.9.9
- `next` is latest CKAN 2.10.x, currently 2.10.1

All other tags will match the releases of this repository.
The version of CKAN in each of these images will be the same as the version
of `latest` at the time of the release.
E.g. at the moment, they will all be 2.9.x.

To use any of these tags just start your `Dockerfile` with
`FROM naturalhistorymuseum/ckantest:<tag>`.

## Building

To build and publish these images, run:

```bash
# next
./release.sh next

# latest
./release.sh latest

# a version, e.g. 0.3.3
./release.sh <version>
```

It would be best to have github actions setup to push automatically on release, but I
_think_ because we're not using a paid for docker hub account we'd have to put one of
our user credentials into github's secrets in order for it to have permission to push
to docker hub and that's not a great way to live.

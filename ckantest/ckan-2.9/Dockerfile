FROM ubuntu:bionic

ENV CKAN_VARIETY="ckan"
ENV CKAN_BRANCH="ckan-2.9.9"
ENV PYTHON_VERSION="3.8"
ENV NODE_VERSION="15"

RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get -q -y update && \
    apt-get -q -y upgrade && \
    apt-get -q -y install software-properties-common && \
    add-apt-repository universe && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get -q -y update && \
    apt-get -q -y install \
        # install system packages required by ckan
        python${PYTHON_VERSION} \
        python${PYTHON_VERSION}-dev \
        python${PYTHON_VERSION}-venv \
        libpq-dev \
        libxml2-dev \
        libxslt-dev \
        libgeos-dev \
        libssl-dev \
        libffi-dev \
        postgresql-client \
        build-essential \
        supervisor \
        # install packages for additional bits and bobs (like the entrypoint script)
        wget \
        git \
        curl \
        netcat \
        uuid-runtime \
        libsasl2-dev \
    && apt-get -q clean \
    && rm -rf /var/lib/apt/lists/*

# install nodejs
RUN curl -sL "https://deb.nodesource.com/setup_${NODE_VERSION}.x" | bash && \
    apt-get install -q -y nodejs && \
    npm update -g npm

# we're gonna use a venv for a couple of reasons. Firstly, it avoids any OS level python package
# clashes/dependencies. Secondly, it matches how we run stuff on the live servers. And finally, it
# means we can use a different version of python3 to the one shipped with ubuntu 18.04.
# For info on the next 3 lines: https://pythonspeed.com/articles/activate-virtualenv-dockerfile/
ENV VIRTUAL_ENV=/venv
RUN "python${PYTHON_VERSION}" -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN pip install -U pip && pip install wheel

RUN mkdir -p /base/data/ckan/storage && \
    mkdir -p /base/src/ckan && \
    mkdir -p /opt/waits

COPY ./ckantest/common/waits /opt/waits/
COPY ./ckantest/common/scripts /opt/scripts/

WORKDIR /base/src/ckan

# setup ckan and its dependencies
RUN git clone "https://github.com/${CKAN_VARIETY}/ckan.git" . && \
    git checkout "${CKAN_BRANCH}" && \
    pip install -r requirement-setuptools.txt && \
    pip install -r requirements.txt && \
    pip install -r dev-requirements.txt && \
    pip install -e . && \
    npm install . --only=prod

# fixes this https://github.com/ckan/ckan/issues/5570
RUN pip install pytest-ckan

# this entrypoint ensures our service dependencies (postgresql, solr and redis) are running before
# running the cmd
ENTRYPOINT ["/bin/bash", "/opt/waits/basic.sh"]

# run the tests
CMD ["bash", "/opt/scripts/run-tests.sh"]

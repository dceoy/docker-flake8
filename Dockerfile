FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

ADD https://bootstrap.pypa.io/get-pip.py /tmp/get-pip.py

RUN set -e \
      && ln -sf bash /bin/sh \
      && ln -s python3 /usr/bin/python

RUN set -e \
      && apt-get -y update \
      && apt-get -y dist-upgrade \
      && apt-get -y install --no-install-recommends --no-install-suggests \
        apt-transport-https ca-certificates curl libssl-dev python3 \
        python3-distutils \
      && apt-get -y autoremove \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

RUN set -e \
      && /usr/bin/python3 /tmp/get-pip.py install -U --no-cache-dir \
        pip pyproject.toml \
      && /usr/local/bin/pip install -U --no-cache-dir \
        autopep8 flake8 flake8-bugbear flake8-isort pep8-naming \
      && rm -f /tmp/get-pip.py

ENTRYPOINT ["/usr/local/bin/flake8"]

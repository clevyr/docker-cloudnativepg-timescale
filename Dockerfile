#syntax=docker/dockerfile:1.10

ARG CLOUDNATIVEPG_VERSION

FROM ghcr.io/cloudnative-pg/postgresql:$CLOUDNATIVEPG_VERSION
USER root

ARG POSTGRES_VERSION
ARG TIMESCALE_VERSION
ARG TIMESCALE_TOOLKIT_VERSION
RUN <<EOT
  set -eux

  # Install dependencies
  apt-get update
  apt-get install -y --no-install-recommends curl

  # Add Timescale apt repo
  . /etc/os-release 2>/dev/null
  echo "deb https://packagecloud.io/timescale/timescaledb/debian/ $VERSION_CODENAME main" >/etc/apt/sources.list.d/timescaledb.list
  curl -Lsf https://packagecloud.io/timescale/timescaledb/gpgkey | gpg --dearmor >/etc/apt/trusted.gpg.d/timescale.gpg

  # Install Timescale
  apt-get update
  apt-get install -y --no-install-recommends "timescaledb-2-postgresql-$POSTGRES_VERSION=$TIMESCALE_VERSION~debian$VERSION_ID"

  # Install Timescale Toolkit
  apt-get update
  apt-get install -y --no-install-recommends "timescaledb-toolkit-postgresql-$POSTGRES_VERSION=1:$TIMESCALE_TOOLKIT_VERSION~debian$VERSION_ID"

  # Cleanup
  apt-get purge -y curl
  rm /etc/apt/sources.list.d/timescaledb.list /etc/apt/trusted.gpg.d/timescale.gpg
  rm -rf /var/cache/apt/*
EOT

USER 26

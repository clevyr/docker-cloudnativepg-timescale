# CloudNativePG Containers with TimescaleDB

[![Build](https://github.com/clevyr/docker-cloudnativepg-timescale/actions/workflows/build.yaml/badge.svg)](https://github.com/clevyr/docker-cloudnativepg-timescale/actions/workflows/build.yaml)

This repo builds Docker images for [CloudNativePG](https://cloudnative-pg.io/) with the [TimescaleDB](https://timescale.com) extension installed.

Both versions are automatically updated by Renovate bot, so new releases will be available within a few hours.

## Images

Images are available at [`ghcr.io/clevyr/cloudnativepg-timescale`](https://github.com/clevyr/docker-cloudnativepg-timescale/pkgs/container/cloudnativepg-timescale). There are tags available for Postgres v14, v15, v16, and v17.

## Deployment

Set `.spec.imageName` in the `Cluster` to use one of the container images provided by this repository.

For example:
```yaml
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: example
spec:
  instances: 3
  imageName: ghcr.io/clevyr/cloudnativepg-timescale:17-ts2
  postgresql:
    shared_preload_libraries:
      - timescaledb
  bootstrap:
    initdb:
      postInitTemplateSQL:
        - CREATE EXTENSION IF NOT EXISTS timescaledb;
```

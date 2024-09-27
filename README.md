# CloudNativePG Containers with TimescaleDB

[![Build](https://github.com/fashionunited/docker-cloudnativepg-timescale/actions/workflows/build.yaml/badge.svg)](https://github.com/fashionunited/docker-cloudnativepg-timescale/actions/workflows/build.yaml)

This repo builds Docker images for [CloudNativePG](https://cloudnative-pg.io/) with the [TimescaleDB](https://timescale.com) extension installed.

Both versions are automatically updated by Renovate bot, so new releases will be available within a few hours.

## Images

Images are available at [`ghcr.io/fashionunited/cloudnativepg-timescale`](https://github.com/fashionunited/docker-cloudnativepg-timescale/pkgs/container/cloudnativepg-timescale). There are tags available for Postgres v14, v15, and v16.

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
  imageName: ghcr.io/fashionunited/cloudnativepg-timescale:16-ts2
  postgresql:
    shared_preload_libraries:
      - timescaledb
  bootstrap:
    initdb:
      postInitTemplateSQL:
        - CREATE EXTENSION IF NOT EXISTS timescaledb;
```

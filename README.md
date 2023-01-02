## MinIO

[![MinIO](https://raw.githubusercontent.com/minio/minio/master/.github/logo.svg?sanitize=true)](https://min.io)

MinIO is High Performance Object Storage released under Apache License v2.0. It is API compatible with Amazon S3 cloud storage service. Using MinIO build high performance infrastructure for machine learning, analytics and application data workloads.

#### [MinIO Public Repo](https://github.com/minio/minio)

## Deployment Instructions

Using the Helm chart [supplied in Repo1](https://repo1.dsop.io/dsop/charts/-/tree/master/stable/minio), a cluster can be spun up using the following. Further deployment instructions can be found [here](https://repo1.dsop.io/dsop/charts/-/tree/master/stable/minio/minio/).

```
$ helm install ./ --name my-minio-deployment -f values-ironbank.yaml
```

## Volumes

To allow MinIO to access a persistent volume, use the following steps.

1. Create a [PersistentVolume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
2. Create a [PersistentVolumeClaim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#expanding-persistent-volumes-claims)
3. Install the Helm chart using the following

```
$ helm install ./ --set persistence.existingClaim=PVC_NAME --name my-minio-deployment -f values-ironbank.yaml 
```

The default directory for configuration files is `/etc/minio/`

## Helm Chart

The public Helm chart for MinIO [here](https://github.com/helm/charts/tree/master/stable/minio)

The secure values file for the recommended configuration and associated chart data can be found [here](https://repo1.dsop.io/dsop/charts/-/tree/master/stable/minio/minio/).

# Playground

[Minikube](https://minikube.sigs.k8s.io) and [Tilt](https://tilt.dev) based local environment for quickly running various applications to play with.

To run all services from the `services` folder, simply run:

```bash
tilt up
```

Alternatively, just pass the names of services you're interested in, e.g.:

```bash
tilt up minio neo4j
```

To startup a `minikube` cluster run `make cluster`.

Needed binaries: `minikube`, `tilt` and `helm`.

## TO ADD

* https://github.com/bitnami/charts/tree/master/bitnami/postgresql
* https://hub.docker.com/r/dpage/pgadmin4/
* https://github.com/bitnami/charts/tree/master/bitnami/cassandra
* https://github.com/bitnami/charts/tree/master/bitnami/etcd
* https://github.com/bitnami/charts/tree/master/bitnami/memcached
* https://github.com/bitnami/charts/tree/master/bitnami/rabbitmq
* https://github.com/bitnami/charts/tree/master/bitnami/kafka
* https://github.com/bitnami/charts/tree/master/bitnami/influxdb
* https://github.com/bitnami/charts/tree/master/bitnami/pytorch
* https://github.com/bitnami/charts/tree/master/bitnami/spark
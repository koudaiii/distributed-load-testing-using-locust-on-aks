# Distributed Load Testing Using locust on AKS

Distributed-load-testing-using-locust-on-aks is making an easy to scalable distributed load testing using AKS and locust.

Table of Contents
=================

- [Distributed Load Testing Using locust on AKS](#distributed-load-testing-using-locust-on-aks)
- [Table of Contents](#table-of-contents)
  - [Getting Started](#getting-started)
    - [1. Require](#1-require)
    - [2. Run Bootstrap script](#2-run-bootstrap-script)
    - [3. Launch locust on your AKS](#3-launch-locust-on-your-aks)
    - [4. How to use WebUI](#4-how-to-use-webui)
  - [Example: using myapp](#example-using-myapp)
  - [Clean-up](#clean-up)
  - [How to use in local](#how-to-use-in-local)
    - [Require](#require)
    - [Use minikube](#use-minikube)
    - [Use docker-compose](#use-docker-compose)
  - [Development](#development)
    - [Require](#require-1)
    - [How to customise](#how-to-customise)
  - [Contribution](#contribution)
  - [Author](#author)
  - [License](#license)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc.go)

## Getting Started

### 1. Require

- `az` command
- `kubectl` command

### 2. Run Bootstrap script

The bootstrap script launches your AKS cluster.

```console
$ script/bootstrap

# Usage: script/bootstrap \
#    [-g MYRESOURCE_GROUP_NAME(Default: DistributedLoadTesting)] \
#    [-a AKS_CLUSTER_NAME(Default: LocustOnAKS)] \
#    [-l LOCATION_NAME(Default: eastus)] \
#    [-c NODE_COUNT(Default: 5)] \
#    [-s NODE_VM_SIZE(Default: Standard_DS3_v2)]
```

### 3. Launch locust on your AKS

```console
$ script/apply
```

### 4. How to use WebUI

```console
$ kubectl port-forward svc/locust-master 8089:8089 -n locust
```

```console
$ open http://localhost:8089
# Change your target url
```

## Example: using myapp

```console
$ script/apply-for-myapp
```

This locust is already set target URL: http://myapp.myapp.svc.cluster.local

## Clean-up

```console
$ script/clean

# Usage: script/clean \
#    [-g MYRESOURCE_GROUP_NAME(Default: DistributedLoadTesting)]
```

## How to use in local

### Require

- `Docker`
- `kubectl`
- `minikube`
  - enable `metrics-server`

### Use minikube

1. deploy to locust and application on minikube

```console
$ kubectl config use-context minikube
$ script/apply
$ script/apply-for-myapp
```

2. port forward to locust-master

```console
$ kubectl port-forward svc/locust-master 8089:8089 -n locust
```

3. open locust

```console
$ open http://localhost:8089
```

### Use docker-compose

```console
$ cd myapp
$ make
$ cd ../
$ docker-compose up --build
```

## Development

### Require

- `locust`

### How to customise

- Copy this repository
- Edit some task files(`locustfile.py` and `lib/`)
- Run `locust` command, And open http://localhost:8089 .
- Edit docker image name at `Makefile` and `kubernetes/` manifest files
- create docker image and push docker image

```console
make push
```

## Contribution

1. Fork ([https://github.com/koudaiii/distributed-load-testing-using-locust-on-aks/fork](https://github.com/koudaiii/distributed-load-testing-using-locust-on-aks/fork))
1. Create a feature branch
1. Commit your changes
1. Rebase your local changes against the master branch
2. Create a new Pull Request

## Author

[koudaiii](https://github.com/koudaiii)

## License

[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

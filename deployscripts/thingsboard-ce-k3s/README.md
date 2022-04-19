# k3s microservices deployment scripts

This folder containing scripts and Kubernetes resources configurations to run ThingsBoard in Microservices mode on **k3s** cluster.

Deployment guide are same as for Minikube [**link**](https://thingsboard.io/docs/user-guide/install/cluster/minikube-cluster-setup/).

Main difference - change INGRESS module form NGINX to TRAEFIK (default ingess module for k3s).

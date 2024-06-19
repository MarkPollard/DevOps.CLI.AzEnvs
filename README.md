# DevOps.CLI.AzEnvs

Creates preconfigured containers with required CLI tools, scripts and extensions for managing Azure environments and AKS clusters.
Sets the promps to show the currently configured Azure user/subscription and Kubernetes cluster/namespace.

## CLI tools

* [az](https://docs.microsoft.com/en-us/cli/azure/) azure cli
* [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/) aliased to `k`
  * [kubectl completion bash](https://kubernetes.io/docs/tasks/tools/included/optional-kubectl-configs-bash-linux/)
* [istioctl](https://preliminary.istio.io/latest/docs/ops/diagnostic-tools/istioctl/) aliased to `ic`
  * [istioctl completion bash](https://preliminary.istio.io/latest/docs/ops/diagnostic-tools/istioctl/#enabling-auto-completion)
* [helm](https://helm.sh/docs/intro/install/)
  * [helm completion bash](https://helm.sh/docs/helm/helm_completion_bash/)
* [jq](https://stedolan.github.io/jq/)


## Configure
Create a .dev.env and a .prod.env file based on .env.example
```bash
INIT_CLUSTER=MY_CLUSTER_NAME
INIT_CLUSTER_RG=MY_CLUSTER_RG
INIT_CLUSTER_NS=MY_DEFAULT_NAMESPACE
INIT_AZ_TENANT=MY_TENANT_ID
INIT_AZ_SUBSCRIPTION=MY_SUBSCRIPTION_ID
```

## Building and running

```bash
docker compose up -d --build
```

## Connecting

```bash
#dev
docker compose exec devops-cli-azenvs-dev /bin/bash --login
#prod
docker compose exec devops-cli-azenvs-prod /bin/bash --login
```

## Removing
```bash
docker compose down -v
```
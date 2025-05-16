# TL500 Cluster Tooling

This directory contains the necessary charts used in order to deploy a TL500 Tech Stack against an OCP 4.X cluster. This assumes that the cluster has valid certificates.

🐞 Please ensure your cluster is the latest Z release - 4.18.z. We test against these. 🐞

This chart is capable of deploying the following:

- Gitlab (version X.Y.Z)
- CodeReady Workspaces (version X.Y.Z)
- Instructor Documentation
- SealedSecrets from Bitnami
- OpenShift Pipelines
- Advanced Cluster Security (StackRox)
- Cluster Logging (LokiStack)
- Certificate Utils
- GitOps Operator (ArgoCD)

## Helm Release

This content is also made available as [Helm Releases](http://rht-labs.com/enablement-framework/) if you prefer to use that method. Otherwise, continue below.

## Installation

It is assumed that LDAP is integrated with the target cluster Oauth Provider. If that is not the case, user will need to supply LDAP integration parameters (see values.yaml file for details)

## Using a chart version

When specifying a chart version, make sure to use the same version for both chart deployments.

1. Install TL500 Base

For 4.18.z OpenShift:

```bash
helm repo add enablement-framework https://rht-labs.com/enablement-framework 
helm repo update
helm search repo enablement-framework
helm install tl500-base enablement-framework/tl500-base --version XYZ --namespace tl500 --create-namespace --timeout=15m
```

2. Install TL500 Course Content

For 4.18.z OpenShift:

```bash
helm repo add enablement-framework https://rht-labs.com/enablement-framework 
helm repo update
helm search repo enablement-framework
helm install tl500-course-content enablement-framework/tl500-course-content --version XYZ --namespace tl500 --create-namespace --timeout=15m
```

## Using the helm chart source code

1. Get the source code

```bash
git clone https://github.com/rht-labs/enablement-framework.git
cd enablement-framework/tooling/charts/tl500-base
helm dep up
```

2. Install TL500 Base

```bash
helm upgrade --install tl500-base . --namespace tl500 --create-namespace --timeout=15m
```

3. Install TL500 Course Content

```bash
cd ../tl500-course-content
helm dep up
helm upgrade --install tl500-course-content . --namespace tl500 --create-namespace --timeout=15m
```

## Deleting

To delete:
```bash
helm uninstall tl500-base --namespace tl500
helm uninstall tl500-course-content --namespace tl500
```

## Gitlab

With Gitlab, it expects to be able to run against a configured LDAP server. This can be achieved by either uncommenting and providing the appropriate values in your `values.yaml` or you can allow the helm chart to discover these values itself.

After this is deployed, you will have a functional gitlab server that can be used along with your LDAP identities.

## CodeReady Workspaces

With CRW, this uses the provided Operator to deploy a CRW instance. With the provided defaults, it restricts uses to two workspaces and allows for only a single `running` instance.

## Running on infra nodes

To run on an infra node (currenly only AWS supported) you can enable this by setting `runOnInfra: true`. This assumes 1) there is at least one infra node configured with the label `node-role.kubernetes.io/infra: ""`.

If you want to provision the node for this too, set the `machineSet` property with appropriate values:

```yaml
# not sure if this should be in this repo but putting somewhere for safe keeping at least 
machineset:
  enabled: true 
  cluster_id: '' # id of the cluster
  region: 'eu-west-2'
  availability_zone: 'eu-west-2a'
  ami_id: 'ami-0993bc7222e12bd80' # eu-west-2 for example, you'd need to find the right ami for the region
```

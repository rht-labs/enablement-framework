# TL500 Cluster Tooling

This directory contains the necessary charts used in order to deploy a TL500 Tech Stack against an OCP 4.X cluster. This assumes that the cluster has valid certificates.

This chart is capable of deploying the following:

- Gitlab (version X.Y.Z)
- CodeReady Workspaces (version X.Y.Z)
- Instructor Documentation
- SealedSecrets from Bitnami
- OpenShift Pipelines
- Advanced Cluster Security (StackRox)
- Cluster Logging (ELK)
- Certificate Utils
- GitOps Operator (ArgoCD)

## Helm Release

This content is also made available as [Helm Releases](http://rht-labs.com/enablement-framework/) if you prefer to use that method. Otherwise, continue below.

## Installation

```bash
cd ./tl500
helm dep up
helm upgrade --install tl500 . --namespace tl500 --create-namespace --timeout=15m
```

## Deleting

To delete:
```bash
helm uninstall tl500 --namespace tl500
```

## Gitlab

With Gitlab, it expects to be able to run against a configured LDAP server. This can be acheived by either uncommenting and providing the appropriate values in your `values.yaml` or you can allow the helm chart to discover these values itself.

After this is deployed, you will have a functional gitlab server that can be used along with your LDAP identities.

## CodeReady Workspaces

With CRW, this uses the provided Operator to deploy a CRW instance. With the provided defaults, it restricts uses to two workspaces and allows for only a single `running` instance.

# DO500 Cluster Tooling

This directory contains the necessary charts used in order to deploy a DO500 Tech Stack against an OCP 4.X cluster. This assumes that the cluster has valid certificates.

This chart is capable of deploying the following:

- Gitlab (version X.Y.Z)
- CodeReady Workspaces (version X.Y.Z)
- Instructor Documentation

## Installation

The following needs to be run by someone who is an admin in your OpenShift cluster from within the chart directory.

On a new cluster, no CRD's exist so to avoid this, we install the operator subscriptions first as its own release:
```bash
helm install do500-operator tooling/charts/do500 --namespace do500 --set subscriptions.only=true
```

This will spin up the CRW workspace operator in the `do500-workspaces` project.

To install the rest of the applications, you can run the following:
```bash
helm install do500 tooling/charts/do500 --namespace do500
```

To uninstall, you can just do the reverse:
```bash
helm uninstall do500 --namespace do500
helm uninstall do500-operator --namespace do500
```

## Gitlab

With Gitlab, it expects to be able to run against a configured LDAP server. This can be acheived by either uncommenting and providing the appropriate values in your `values.yaml` or you can allow the helm chart to discover these values itself.

**Note**: There is currently a bug where the chart only looks at the first configured IdentityProvider within the default `OAuth` configuration of the OpenShift cluster to check for an ldap configuration. This is being tracked <here>. In the mean time, you can change it to look at the appropriate position by changing the following occurrences of:

```
code sample
```

to look like

```
code sample
```

After this is deployed, you will have a functional gitlab server that can be used along with your LDAP identities.

## CodeReady Workspaces

With CRW, this uses the provided Operator to deploy a CRW instance. With the provided defaults, it restricts uses to two workspaces and allows for only a single `running` instance.


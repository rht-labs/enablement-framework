# DO500 Cluster Tooling

This directory contains the necessary charts used in order to deploy a DO500 Tech Stack against an OCP 4.X cluster. This assumes that the cluster has valid certificates.

This chart is capable of deploying the following:

- Gitlab (version X.Y.Z)
- CodeReady Workspaces (version X.Y.Z)
- Instructor Documentation

## Installation

The following needs to be run by someone who is an admin in your OpenShift cluster.

To install this chart, you can run the following from within the chart directory:

```
helm install charts/do500 --create-namespace do500

## WORKAROUND
$ oc new-project do500
$ cd ./charts/do500
$ helm install . --generate-name
```

To uninstall, you can just do the reverse:

```
helm uninstall charts/do500 --namespace do500

## WORKAROUND
$ oc project do500
$ helm list
$ helm uninstall chart-1609846719
```

## Upgrade Helm Chart

The following procedure allows to upgrade helm charts in order to modify kubernetes objects in a GitOps way:

- Modify values, objects, etc

- List helm instances in do500 namespace

```
$ oc project do500
$ helm list
NAME                    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
chart-1609846719        ipa             2               2021-01-05 12:46:58.501125322 +0100 CET deployed        do500-env-0.0.1 0.0.1      
```

- Upgrade helm instance

```
$ helm upgrade chart-1609846719 charts/do500
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


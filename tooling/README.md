# DO500 Cluster Tooling

This directory contains the necessary charts used in order to deploy a DO500 Tech Stack against an OCP 4.X cluster. This assumes that the cluster has valid certificates.

This chart is capable of deploying the following:

- Gitlab (version X.Y.Z)
- CodeReady Workspaces (version X.Y.Z)
- IDM IPA Server (*with LDAP integration)
- Instructor Documentation

## Installation

The following needs to be run by someone who is an admin in your OpenShift cluster.

To install this chart, you can run the following from within the chart directory:

```
helm install --create-namespace do500 --namespace do500 charts/do500
```

To uninstall, you can just do the reverse:

```
helm uninstall --namespace do500 charts/do500
```

## Upgrade Helm Chart

The following procedure allows to upgrade helm charts in order to modify kubernetes objects in a GitOps way:

- Modify values, objects, etc

- Upgrade helm instance

```
$ helm upgrade --namespace do500 charts/do500
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

### GitLab and IPA Server Users

First at all, it is required to install IPA server in order to be able to login IPA Users.

Once Gitlab has been installed and configured to make use of a LDAP provider, it is possible to access to the WebUI:

- Obtain Openshift Route

```
$ oc get route -n do500-gitlab
```

- Access WebUI with *username/password* credentials

## CodeReady Workspaces

With CRW, this uses the provided Operator to deploy a CRW instance. With the provided defaults, it restricts uses to two workspaces and allows for only a single `running` instance.

### CodeReady and IPA Server Users

First at all, it is required to configure IPA server as Openshift provider in order to be able to login IPA Users.

Once CodeReady Workspaces has been installed and configured to make use of Openshift providers, it is possible to access to the WebUI:

- Obtain Openshift Route

```
$ oc get route -n do500-workspaces
```

- Access WebUI with *username/password* credentials


## IPA Server

IPA provides a way to create an identity domain that allows machines to enroll to a domain and immediately access identity information required for single sign-on and authentication services, as well as policy settings that govern authorization and access. This manual covers all aspects of installing, configuring, and managing IPA domains, including both servers and clients. This guide is intended for IT and systems administrators.

Once IPA server has been installed, it is possible to access to the WebUI:

- Obtain Openshift Route

```
$ oc get route -n do500-ipa
```

- Access WebUI with **admin** and the respective password defined in values.yaml

### Configure OCP with LDAPAuth

By default "IPA Auth Openshift" feature is disabled because it is not possible to modify oauth object, named *cluster*, by default. In order to configure IPA server as Openshift Auth provider manually, it is required to follow next steps:

```
$ helm template --debug --set ipaserver.auth_ocp.enabled=true --output-dir /tmp charts/do500
$ oc apply -f  /tmp/do500-env/templates/ocp-auth-ldap/secret.yaml
$ oc apply -f  /tmp/do500-env/templates/ocp-auth-ldap/oauth.yaml
```



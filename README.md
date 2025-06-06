# enablement-framework

This repository contains the components needed to run a TL500 enablement session:
- [Tooling](tooling) - The required tools to deploy once a cluster is available, see [tooling/README.md](tooling/README.md)

## Helm Releases
- [Helm Releases](http://rht-labs.com/enablement-framework) - The above tooling made available as Helm Releases 

## OCP Setup

To install the above tooling, you need a specific OCP setup, with an LDAP installed:

1. get a running OCP 4.18 cluster with sufficient resources
   - Requirements
     - 3 control plane nodes with
       - 16 GB Memory
       - 4 CPU Cores
       - 120 GB FS storage (less might be sufficient)
     - 3 worker nodes with
       - 64 GB Memory
       - 16 CPU Cores
       - 120 GB FS storage (less might be sufficient)
   - If you have access to the [Red Hat Demo Platform](https://catalog.demo.redhat.com/catalog), you can do the following to achieve this setup:
     	1. order an [AWS Blank Open Environment](https://catalog.demo.redhat.com/catalog?item=babylon-catalog-prod/sandboxes-gpte.sandbox-open.prod&utm_source=webapp&utm_medium=share-link)
     	2. install Openshift 4.18 (e.g. using [[Asier Cidon's git ](https://gitlab.consulting.redhat.com/acidonpe/ocp-install-openenv-aws)](https://gitlab.consulting.redhat.com/acidonpe/ocp-install-openenv-aws))
     		- ```computes_type='m5.4xlarge'```
     		- ```master_sno_type='m6i.4xlarge'```
2. Install LDAP and create users
   1. follow steps described in [https://rht-labs.com/tech-exercise/#/99-the-rise-of-the-cluster/1-tooling-installation?id=user-management](https://rht-labs.com/tech-exercise/#/99-the-rise-of-the-cluster/1-tooling-installation?id=user-management)
   2. in OCP
      - modify OAuth yaml ( ```https://<ocp-web-console>/k8s/cluster/config.openshift.io~v1~OAuth/cluster``` ) to use bind-dn ```admin```
      - modify respective secret (referenced from OAuth yaml above) to use bind-password ```Passw0rd123```
      - add user group ```student``` ( ```https://<ocp-web-console>/k8s/cluster/user.openshift.io~v1~Group/~new``` )
3. install [TL500-base chart](enablement-framework/tooling/charts/tl500-base/Chart.yaml) (located in [tooling](tooling))
4. Test all the things using one of the following
   - [https://rht-labs.com/tech-exercise/#/1-the-manual-menace/](https://rht-labs.com/tech-exercise/#/1-the-manual-menace/) (web page)
   - [https://github.com/rht-labs/tech-exercise](https://github.com/rht-labs/tech-exercise) (source code)
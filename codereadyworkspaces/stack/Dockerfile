FROM registry.redhat.io/codeready-workspaces/plugin-java8-rhel8:2.10-4

ENV ARGOCD_VERSION=2.0.5
ENV YQ_VERSION=4.11.2
ENV HELM_VERSION=3.6.3
ENV KUBESEAL_VERSION=v0.13.1
ENV TEKTON_VERSION=0.19.1
ENV OC_VERSION=4.8.3
ENV JQ_VERSION=1.6
ENV CONFTEST_VERSION=0.23.0
ENV ZSH_VERSION=5.8

USER root

# argo
RUN curl -sL https://github.com/argoproj/argo-cd/releases/download/v${ARGOCD_VERSION}/argocd-linux-amd64 -o /usr/local/bin/argocd && \
    chmod -R 775 /usr/local/bin/argocd && \
    echo "🐙🐙🐙🐙🐙"

#🦭🦭🦭kubeseal 🦭
RUN curl -sL https://github.com/bitnami-labs/sealed-secrets/releases/download/${KUBESEAL_VERSION}/kubeseal-linux-amd64 -o /usr/local/bin/kubeseal && \
    chmod -R 755 /usr/local/bin/kubeseal && \
    echo "🦭🦭🦭🦭🦭"

# tekton
RUN curl -L https://mirror.openshift.com/pub/openshift-v4/clients/pipeline/latest/tkn-linux-amd64-${TEKTON_VERSION}.tar.gz | tar --no-same-owner -C /usr/local/bin -xz tkn && \
    echo "🐈🐈🐈🐈🐈"

# oc client
RUN rm -f /usr/bin/oc && \
    curl -L https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/${OC_VERSION}/openshift-client-linux.tar.gz | tar -C /usr/local/bin -xzf -&& \
    echo "🐨🐨🐨🐨🐨"

# jq / yq
RUN curl -sLo /usr/local/bin/jq https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 && \
    chmod +x /usr/local/bin/jq && \
    curl -sLo /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64 && \
    chmod +x /usr/local/bin/yq && \
    echo "🦨🦨🦨🦨🦨"
 
# Conftest? This will make Gareth Happy :P
RUN curl --fail -skL https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz | tar zxf - -C /usr/local/bin conftest && \
    echo "🌲🌲🌲🌲🌲"

# zsh
ADD ubi8.repo /etc/yum.repos.d/ubi8.repo
RUN dnf install -y centos-gpg-keys --nogpgcheck && \
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial && \
    dnf install -y zsh

# helm
RUN curl -skL -o /tmp/helm.tar.gz https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    tar -C /tmp -xzf /tmp/helm.tar.gz && \
    mv -v /tmp/linux-amd64/helm /usr/local/bin && \
    chmod -R 775 /usr/local/bin/helm && \
    rm -rf /tmp/linux-amd64 && \
    echo "⚓️⚓️⚓️⚓️⚓️"

# sort out git...
RUN echo "git config --global http.sslVerify false" >> /etc/bashrc && \
    echo "git config --global http.sslVerify false" >> /etc/zshrc && \
    echo "git config --global user.name 'Derek Dinosaur'" >> /etc/bashrc && \
    echo "git config --global user.name 'Derek Dinosaur'" >> /etc/zshrc && \
    echo "git config --global user.email 'derek@dinosaur.com'" >> /etc/bashrc && \
    echo "git config --global user.email 'derek@dinosaur.com'" >> /etc/zshrc && \
    echo "🤗🤗🤗🤗🤗"
    
# # docsify-cli
RUN npm i -g docsify-cli && \
    echo "📚📚📚📚📚"

# clean up 
RUN rm -rf /tmp/* && \
    rm -rf $HOME/.cache && \
    chown 1001 /home/jboss/.config && \
    echo "🧹🧹🧹🧹🧹"

# swap to no priv user 
USER 1001

# oh-my-zsh 
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh && \
    cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc && \
    echo "😎😎😎😎😎"
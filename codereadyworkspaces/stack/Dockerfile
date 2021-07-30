FROM registry.redhat.io/codeready-workspaces/plugin-java8-rhel8:2.10-4

ENV ARGOCD_VERSION=2.0.5
ENV YQ_VERSION=v4.11.1
ENV HELM_VERSION=v3.6.0
ENV KUBESEAL_VERSION=v0.13.1
ENV TEKTON_VERSION=0.20.0
ENV OC_VERSION=4.8.3
ENV JQ_VERSION=1.6
ENV CONFTEST_VERSION=0.23.0
ENV ZSH_VERSION=5.8

USER root

# argo
RUN curl -sL https://github.com/argoproj/argo-cd/releases/download/v${ARGOCD_VERSION}/argocd-linux-amd64 -o /usr/local/bin/argocd && \
    chmod -R 775 /usr/local/bin/argocd && \
    echo "🐙🐙🐙🐙🐙"

#helm
RUN  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
     chmod 700 get_helm.sh && \
     ./get_helm.sh --version ${HELM_VERSION} && \
     echo "⚓️⚓️⚓️⚓️⚓️"

#🦭🦭🦭kubeseal 🦭
RUN curl -sL https://github.com/bitnami-labs/sealed-secrets/releases/download/${KUBESEAL_VERSION}/kubeseal-linux-amd64 -o /usr/local/bin/kubeseal && \
    chmod -R 755 /usr/local/bin/kubeseal && \
    echo "🦭🦭🦭🦭🦭"

# tekton
RUN curl -sLO https://github.com/tektoncd/cli/releases/download/v${TEKTON_VERSION}/tkn_${TEKTON_VERSION}_Linux_x86_64.tar.gz && \
    tar xvzf tkn_${TEKTON_VERSION}_Linux_x86_64.tar.gz -C /usr/local/bin/ tkn  && \
    echo "🐈🐈🐈🐈🐈"

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
ADD centos8.repo /etc/yum.repos.d/centos8.repo
RUN dnf install -y zsh && \
    git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh && \
    cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc && \
    echo "😎😎😎😎😎"

# sort out git...
RUN echo "git config --global http.sslVerify false" >> /etc/bashrc && \
    echo "git config --global http.sslVerify false" >> /etc/zshrc && \
    echo "git config --global user.name 'Derek Dinosaur'" >> /etc/bashrc && \
    echo "git config --global user.name 'Derek Dinosaur'" >> /etc/zshrc && \
    echo "git config --global user.email 'derek@dinosaur.com'" >> /etc/bashrc && \
    echo "git config --global user.email 'derek@dinosaur.com'" >> /etc/zshrc && \
    echo "🤗🤗🤗🤗🤗"

# docsify-cli
RUN npm i -g docsify-cli && \
    echo "📚📚📚📚📚"

USER 1001
FROM registry.redhat.io/codeready-workspaces/plugin-java8-rhel8

USER root

# Extra repos not part of ubi
COPY mongodb-org-3.6.repo /etc/yum.repos.d/
COPY google-chrome.repo /etc/yum.repos.d/

# Using CentOS repos to support dependencies needed for google-chrome-stable
COPY centos.repo /etc/yum.repos.d/

# Install
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
    yum install -y zsh cowsay google-chrome-stable mongodb-org-server mongodb-org-tools mongodb-org-shell && \
    pip install ansible && \
    git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh && \
    cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc && \  
    yum clean all

# Common shell things
RUN echo "git config --global http.sslVerify false" >> /etc/bashrc
RUN echo "git config --global http.sslVerify false" >> /etc/zshrc
RUN echo "git config --global user.name 'Derek Dinosaur'" >> /etc/bashrc
RUN echo "git config --global user.name 'Derek Dinosaur'" >> /etc/zshrc
RUN echo "git config --global user.email 'derek@dinosaur.com'" >> /etc/bashrc
RUN echo "git config --global user.email 'derek@dinosaur.com'" >> /etc/zshrc

# Fixup helpers
COPY fix-api-url.sh /usr/local/bin
RUN echo "source /usr/local/bin/fix-api-url.sh" >> /etc/bashrc

# Install jq
# http://stedolan.github.io/jq/
RUN curl -o /usr/local/bin/jq -L https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 && \
  chmod +x /usr/local/bin/jq

# Add Let's Encrypt CA to OS trusted store
RUN curl -o /etc/pki/ca-trust/source/anchors/lets-encrypt-x3-cross-signed.crt https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem.txt && \
    update-ca-trust extract

# Default User
USER 1001
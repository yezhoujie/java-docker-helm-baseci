FROM maven:3.6-jdk-8-alpine
LABEL Dockerfile = "baseci"
ENV HELM_VERSION="v2.11.0" \
    YQ_VERSION="2.1.1"
RUN apk --no-cache add \
    docker \
    mysql-client \
    xmlstarlet \
    openssl \
    ca-certificates \
    openssh \
    git \
    jq
RUN wget -O /usr/bin/yq \
    "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64" && \
    chmod +x /usr/bin/yq  && \
    wget "https://enjoy-skins.oss-cn-hangzhou.aliyuncs.com/k8s-test/helm-${HELM_VERSION}-linux-amd64.tar.gz" && \
    tar xzf "helm-${HELM_VERSION}-linux-amd64.tar.gz" -C tmp && \
    rm -r "helm-${HELM_VERSION}-linux-amd64.tar.gz" && \
    mv /tmp/linux-amd64/helm /usr/bin/helm && \
    helm init -c --skip-refresh && \
    helm repo remove stable && \
    helm repo add stable https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts && \
    helm repo add --username=admin --password=Harbor12345  55else-repo  http://10.66.0.18:8888/chartrepo/55else && \
    helm repo update  && \
    helm plugin install https://github.com/chartmuseum/helm-push && \
    mkdir -p /tmp/helm && \
    cp -r /root/.helm /tmp/helm



FROM mcr.microsoft.com/azure-cli:2.61.0

RUN az aks install-cli && \
    apk add --no-cache helm --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community && \
    apk add --no-cache util-linux-misc --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main && \
    apk add --no-cache bash bash-completion && \
    apk add --no-cache git curl && \
    ISTIO_VERSION="$(curl -sL https://github.com/istio/istio/releases | grep -o 'releases/[0-9]*.[0-9]*.[0-9]*/' | sort -V | tail -1 | awk -F'/' '{ print $2}')" && \
    ISTIO_VERSION="${ISTIO_VERSION##*/}" && curl -sL https://istio.io/downloadIstio | sh - && \
    cp "/istio-${ISTIO_VERSION}/bin/istioctl" /usr/local/bin && cp "/istio-${ISTIO_VERSION}/tools/istioctl.bash" /usr/local/bin && \
    rm -rf "/istio-${ISTIO_VERSION}" && \
    TERRAFORM_VERSION="$(curl -sL https://releases.hashicorp.com/terraform | grep -o '/terraform/[0-9]*.[0-9]*.[0-9]*/' | sort -V | tail -1 | awk -F'/' '{ print $3}')" && \
    TERRAFORM_VERSION="${TERRAFORM_VERSION##*/}" && \
    wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    unzip "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && rm "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    mv terraform /usr/local/bin

RUN curl -s https://ohmyposh.dev/install.sh | bash -s

COPY profile.d/ /etc/profile.d/
COPY scripts/ /devops-cli-azenvs/bin/
COPY theme/ /root/

ENTRYPOINT [ "/bin/bash", "--login" ]
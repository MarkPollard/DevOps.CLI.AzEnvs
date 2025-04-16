FROM mcr.microsoft.com/azure-cli:2.71.0

RUN az aks install-cli && \
    tdnf -y install helm && \
    tdnf -y install bash bash-completion && \
    tdnf -y install git curl wget unzip gawk tar vi && \
    curl -LO "https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion" && \
    mv az.completion /usr/local/bin && \
    ISTIO_VERSION="$(curl -sL https://github.com/istio/istio/releases | grep -o 'releases/[0-9]*.[0-9]*.[0-9]*/' | sort -V | tail -1 | awk -F'/' '{ print $2}')" && \
    ISTIO_VERSION="${ISTIO_VERSION##*/}" && curl -sL https://istio.io/downloadIstio | sh - && \
    cp "/istio-${ISTIO_VERSION}/bin/istioctl" /usr/local/bin && cp "/istio-${ISTIO_VERSION}/tools/istioctl.bash" /usr/local/bin && \
    rm -rf "/istio-${ISTIO_VERSION}" && \
    TERRAFORM_VERSION="$(curl -sL https://releases.hashicorp.com/terraform | grep -o '/terraform/[0-9]*.[0-9]*.[0-9]*/' | sort -V | tail -1 | awk -F'/' '{ print $3}')" && \
    TERRAFORM_VERSION="${TERRAFORM_VERSION##*/}" && \
    curl -LO "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    unzip "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && rm "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    mv terraform /usr/local/bin && \
    mkdir k9s-installation && cd ./k9s-installation && \
    K9S_VERSION="$(curl https://api.github.com/repos/derailed/k9s/tags | jq -r '.[0].name')" && \
    curl -LO "https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz" && \
    tar xf k9s_Linux_amd64.tar.gz && mv k9s /usr/local/bin && \
    cd ../ && rm -rf k9s-installation

RUN curl -s https://ohmyposh.dev/install.sh | bash -s

COPY profile.d/ /etc/profile.d/
COPY scripts/ /devops-cli-azenvs/bin/
COPY theme/ /root/

ENTRYPOINT [ "/bin/bash", "--login" ]
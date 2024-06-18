FROM mcr.microsoft.com/azure-cli:2.61.0

RUN az aks install-cli && \
    apk add --no-cache helm --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community && \
    apk add --no-cache util-linux-misc --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main && \
    apk add --no-cache bash bash-completion && \
    apk add --no-cache git curl

RUN curl -s https://ohmyposh.dev/install.sh | bash -s

COPY profile.d/ /etc/profile.d/
COPY scripts/ /devops-cli-aks/bin/
COPY theme/ /root/

ENTRYPOINT [ "/bin/bash", "--login" ]
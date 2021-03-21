FROM alpine:edge as downloader
ARG CONCOURSE_VERSION=7.1.0
ARG YTT_VERSION=0.31.0
RUN apk add --no-cache curl
RUN curl -L https://github.com/concourse/concourse/releases/download/v${CONCOURSE_VERSION}/fly-${CONCOURSE_VERSION}-linux-amd64.tgz -o /fly.tgz && tar -xvf /fly.tgz
RUN curl -L https://github.com/vmware-tanzu/carvel-ytt/releases/download/v${YTT_VERSION}/ytt-linux-amd64 -o /ytt

FROM alpine:edge
RUN apk add --no-cache bash tzdata ca-certificates
COPY --from=downloader /fly /usr/local/bin/fly
COPY --from=downloader /ytt /usr/local/bin/ytt
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.6.0/wait /wait
RUN chmod +x /wait
RUN chmod +x /usr/local/bin/fly
RUN chmod +x /usr/local/bin/ytt

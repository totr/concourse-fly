FROM alpine:edge as downloader
ARG CONCOURSE_VERSION=5.4.0
RUN apk add --no-cache curl
RUN curl -L https://github.com/concourse/concourse/releases/download/v${CONCOURSE_VERSION}/fly-${CONCOURSE_VERSION}-linux-amd64.tgz -o /fly.tgz && tar -xvf /fly.tgz

FROM alpine:edge
RUN apk add --no-cache bash tzdata ca-certificates
COPY --from=downloader /fly /usr/local/bin/fly
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.5.1/wait /wait
RUN chmod +x /wait
RUN chmod +x /usr/local/bin/fly

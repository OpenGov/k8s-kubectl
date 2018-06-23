FROM alpine

LABEL maintainer="OpenGov, Inc."

ARG VCS_REF
ARG BUILD_DATE

# Metadata
ARG BRANCH=unknown
ARG BUILD_URL=http://localhost
ARG PULL_REQUEST=false
ARG REPO_URL='https://github.com/OpenGov/k8s-kubectl'
ARG REVISION={$VCS_REF}
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/OpenGov/k8s-kubectl" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      com.opengov.build.branch=${BRANCH} \
      com.opengov.build.build-url=${BUILD_URL} \
      com.opengov.build.pull-request=${PULL_REQUEST} \
      com.opengov.build.repo-url=${REPO_URL} \
      com.opengov.build.revision=${REVISION} \
      com.opengov.build.service=kubectl


ENV KUBE_LATEST_VERSION="v1.9.8"

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*

WORKDIR /root
ENTRYPOINT ["kubectl"]
CMD ["help"]

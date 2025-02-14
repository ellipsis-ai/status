FROM frolvlad/alpine-scala:2.12
MAINTAINER Matteo Melani <m@ellipsis.ai>

# Install some basic tools
RUN apk add --update bash curl openssl ca-certificates tar gzip openssh zip

# Git
RUN apk add --update git

# Node and Npm
RUN apk add --update nodejs nodejs-npm && npm install npm@latest -g

# Docker and docker compose
RUN apk add --update docker

# AWS CLI tools
RUN apk --no-cache update && \
    apk --no-cache add python py-pip py-setuptools ca-certificates && \
    pip --no-cache-dir install awscli && \
    rm -rf /var/cache/apk/*

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN addgroup -S circleci && adduser -S -g circleci circleci
RUN passwd -d -u circleci
RUN echo "circleci ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

USER circleci

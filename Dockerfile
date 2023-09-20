ARG TAG=0.0.1
FROM ubuntu:latest
FROM gcc:latest

###################################################################################################
# Set up guest user  and tools for development
ARG DEV_GROUP_ID=8888
ARG ID_NAME=guest
ENV ID_NAME=${ID_NAME}
# Create default users
RUN groupadd -g ${DEV_GROUP_ID} developers \
    && useradd -ms /bin/bash $ID_NAME \
    && usermod -aG sudo $ID_NAME \
    && usermod -aG developers $ID_NAME \
    && echo "${ID_NAME}:${ID_NAME}" | chpasswd
USER $ID_NAME
WORKDIR /home/${ID_NAME}
RUN mkdir /home/${ID_NAME}/.ssh

###################################################################################################
# Build the image as root from the / folder
USER root
WORKDIR /

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    build-essential \
    g++ \
    python3-dev \
    autotools-dev \
    libicu-dev \
    libbz2-dev \
    libboost-all-dev
ARG TAG=0.0.1
FROM ubuntu:jammy
ARG DEBIAN_FRONTEND=noninteractive

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
    libboost-all-dev \
    libgtest-dev \
    cmake \
    sudo \
    ca-certificates \
    git

RUN apt-get update && \
    apt-get install -y \
    lsb-release && \
    apt-get clean all

# Build GTest library
RUN cd /usr/src/googletest && \
    cmake . && \
    cmake --build . --target install

# Install bazel for building drake
RUN apt install -y \
    apt-transport-https \
    curl \
    gnupg

RUN curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
RUN mv bazel-archive-keyring.gpg /usr/share/keyrings
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list

RUN apt update && \
    apt install -y bazel-6.3.0

# It would be nice to get Drake installed via the Dockerfile, but let's defer this until later. I ran into permissions issues that I have not yet resolved.
# Install drake
# WORKDIR /opt/tools/
# RUN git clone --filter=blob:none https://github.com/RobotLocomotion/drake.git
# RUN cd drake && \
#     ./setup/ubuntu/install_prereqs.sh -y

# RUN cd drake && \
#     bazel-6.3.0 build //...


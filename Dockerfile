FROM golang:latest

WORKDIR /root/project

# Configure to avoid redundant error "debconf: delaying package configuration, since apt-utils is not installed".
# See https://code.visualstudio.com/docs/remote/containers-advanced#_debconf-delaying-package-configuration-since-aptutils-is-not-installed.
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install --no-install-recommends apt-utils

# Verify git, process tools, lsb-release (common in install instructions for CLIs) installed.
RUN apt-get -y install git iproute2 procps lsb-release

# Enable Go Modules.
ENV GO111MODULE=on

# Clean up.
RUN apt-get autoremove -y && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Revert workaround of avoiding redundant error "debconf: delaying package configuration, since apt-utils is not installed".
# See https://code.visualstudio.com/docs/remote/containers-advanced#_debconf-delaying-package-configuration-since-aptutils-is-not-installed.
ENV DEBIAN_FRONTEND=dialog

# Expose service ports.
EXPOSE 8000

# Note this Dockerfile needs the root project directory to be mounted as a volume in the container.

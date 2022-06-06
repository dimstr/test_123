FROM gitpod/workspace-full

ENV FLUTTER_HOME=/home/gitpod/flutter \
    FLUTTER_VERSION=3.0.0

# Install dart
USER root

RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    apt-get update && \
    apt-get -y install libpulse0 build-essential libkrb5-dev gcc make && \
    apt-get clean && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*;

USER gitpod

# Install Flutter sdk
RUN cd /home/gitpod && \
  wget -qO flutter_sdk.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.0.0-stable.tar.xz && \
  tar -xvf flutter_sdk.tar.xz && rm flutter_sdk.tar.xz

# Web is available on master channel
RUN $FLUTTER_HOME/bin/flutter channel stable && $FLUTTER_HOME/bin/flutter upgrade

# Change the PUB_CACHE to /workspace so dependencies are preserved.
ENV PUB_CACHE=/workspace/.pub_cache

# add executables to PATH
RUN echo 'export PATH=${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PUB_CACHE}/bin:${FLUTTER_HOME}/.pub-cache/bin:$PATH' >>~/.bashrc
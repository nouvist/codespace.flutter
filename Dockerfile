FROM ubuntu:latest

# skip downloading on build
# COPY flutter_linux_*.tar.xz /tmp/flutter.tar.xz
# COPY commandlinetools-linux-*.zip /tmp/cmdline.zip

COPY install.sh /tmp/install.sh
RUN chmod +x /tmp/install.sh && \
  /tmp/install.sh && \
  rm /tmp/install.sh

USER vscode

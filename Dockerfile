FROM ubuntu:latest

# skip downloading on build
# COPY flutter_linux_*.tar.xz /tmp/flutter.tar.xz
# COPY commandlinetools-linux-*.zip /tmp/cmdline.zip

COPY *.sh /tmp/
RUN chmod +x /tmp/*.sh
RUN /tmp/install.sh

USER vscode
RUN /tmp/postinstall.sh

FROM docker.io/library/archlinux:base-devel

LABEL com.github.containers.toolbox="true" \
      name="devbox" \
      version="latest" \
      usage="This image is meant to be used with the distrobox command" \
      summary="Image for Arch Linux dev container" \
      maintainer="Dobli"

# Enable locales for de_DE
RUN echo "NoExtract   = !usr/share/*locales/de_?? !usr/share/*locales/i18n* !usr/share/*locales/iso*" >> /etc/pacman.conf

# Install extra packages
COPY extra-packages /
RUN pacman -Syu --needed --noconfirm - < extra-packages
RUN rm /extra-packages

# Clean up cache
RUN yes | pacman -Scc

# Enable sudo permission for wheel users
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/toolbox

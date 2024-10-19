FROM ghcr.io/ublue-os/arch-distrobox

LABEL com.github.containers.toolbox="true" \
      name="devbox" \
      version="latest" \
      usage="This image is meant to be used with the distrobox command" \
      summary="Image for Arch Linux dev container" \
      maintainer="Dobli"

# Install extra pacman packages
COPY extra-packages /
RUN pacman -Syu --needed --noconfirm - < extra-packages
RUN rm /extra-packages
# Clean up cache
RUN yes | pacman -Scc

# Install node packages
RUN yarn global add neovim --prefix /usr/local

# Enable locales for de_DE
RUN sed -i "s|#.*de_DE.UTF-8|de_DE.UTF-8|g" /etc/locale.gen
RUN locale --all-locales

# Enable sudo permission for wheel users
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/toolbox

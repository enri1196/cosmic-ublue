#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf install -y @cosmic-desktop-environment cosmic-greeter xdg-desktop-portal xdg-desktop-portal-cosmic

# Boot into a graphical session with COSMIC.
# COSMIC provides its own display manager (cosmic-greeter).
systemctl set-default graphical.target
systemctl enable cosmic-greeter.service
# Some images can be missing the display-manager.service alias; ensure it's present.
ln -sf /usr/lib/systemd/system/cosmic-greeter.service /etc/systemd/system/display-manager.service

### Gaming essentials
dnf install -y \
  gamescope \
  gamemode \
  mangohud \
  steam-devices \
  vkbasalt \
  vulkan-tools

# Flatpak
dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Gaming apps (Flatpaks)
flatpak install -y --system flathub \
  dev.vencord.Vesktop \
  com.heroicgameslauncher.hgl \
  com.valvesoftware.Steam

# Utils apps (Flatpaks)
flatpak install -y --system app.zen_browser.zen \
  com.bitwarden.desktop \
  org.telegram.desktop \
  com.github.tchx84.Flatseal \
  org.qbittorrent.qBittorrent

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket

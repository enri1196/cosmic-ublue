#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf install -y @cosmic-desktop-environment cosmic-greeter

# Boot into a graphical session with COSMIC.
# COSMIC provides its own display manager (cosmic-greeter).
systemctl set-default graphical.target
systemctl enable cosmic-greeter.service
# Some images can be missing the display-manager.service alias; ensure it's present.
ln -sf /usr/lib/systemd/system/cosmic-greeter.service /etc/systemd/system/display-manager.service

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket

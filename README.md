# proxmox-backup-build
A Docker image to build proxmox-backup from source

## Motivation

The Proxmox team release a Debian package for `proxmox-backup-client`, but I run Ubuntu.
While sometimes it works, the current Debian package requires an older and insecure
libssl.

This Docker image will build binaries (but not yet a package) suitable to run on
Ubuntu 22.04, and perhaps others.

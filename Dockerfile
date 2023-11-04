FROM ubuntu:latest AS buildbox

RUN apt update && apt upgrade -y \
    && apt install -y --no-install-recommends git curl ca-certificates clang pkg-config libssl-dev libudev-dev libapt-pkg-dev libfuse3-dev acl-dev uuid-dev libsystemd-dev libsgutils2-dev dpkg-dev
RUN curl --proto '=https' --tlsv1.3 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="${PATH}:/root/.cargo/bin"
RUN cargo version

FROM buildbox AS sourcebox
WORKDIR /proxmox
RUN git clone git://git.proxmox.com/git/proxmox-backup.git
RUN git clone git://git.proxmox.com/git/proxmox.git
RUN git clone git://git.proxmox.com/git/proxmox-fuse.git
RUN git clone git://git.proxmox.com/git/proxmox-acme-rs.git
RUN git clone git://git.proxmox.com/git/pathpatterns.git
RUN git clone git://git.proxmox.com/git/pxar.git
WORKDIR /proxmox/proxmox-backup
RUN sed '/{\s*path\s*=\s*"../s/#//g' < Cargo.toml > /tmp/Cargo.toml && mv /tmp/Cargo.toml .
RUN rm .cargo/config
RUN cargo update
RUN cargo build --workspace --release
RUN ls -l target/release

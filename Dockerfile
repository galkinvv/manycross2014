# syntax=docker/dockerfile:1.6
FROM ghcr.io/galkinvv/manycross2014:main
ARG DOCKER_RUST_VERSION
# profile minimal is needed to avoid huge rust-docs
RUN rustup toolchain install --profile minimal -t x86_64-pc-windows-gnu -t x86_64-pc-windows-gnullvm -t x86_64-unknown-linux-musl -t x86_64-unknown-linux-gnu -t aarch64-unknown-linux-musl -t aarch64-unknown-linux-gnu -c rust-src -c rust-analyzer -c clippy -c rustfmt ${DOCKER_RUST_VERSION} && \
    rustup default ${DOCKER_RUST_VERSION}
RUN mkdir -p /opt/rustup/rustlld-wrappers/aarch64-unknown-linux-gnu
COPY --chmod=755 <<EOF /opt/rustup/rustlld-wrappers/aarch64-unknown-linux-gnu/ld.lld
#!/bin/bash
exec /opt/rustup/toolchains/${DOCKER_RUST_VERSION}-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/bin/gcc-ld/ld.lld --sysroot /usr/xcc/aarch64-unknown-linux-gnu/aarch64-unknown-linux-gnu/sysroot -L =/usr/lib -L =/lib -L /usr/xcc/aarch64-unknown-linux-gnu/lib/gcc/aarch64-unknown-linux-gnu/10.3.0/ "\$@"
EOF
ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=/opt/rustup/rustlld-wrappers/aarch64-unknown-linux-gnu/ld.lld

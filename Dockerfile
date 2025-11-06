FROM ghcr.io/galkinvv/manycross2014:main
ARG DOCKER_RUST_VERSION
# profile minimal is needed to avoid huge rust-docs
RUN rustup toolchain install --profile minimal -t x86_64-pc-windows-gnu -t x86_64-pc-windows-gnullvm -t x86_64-unknown-linux-musl -t x86_64-unknown-linux-gnu -t aarch64-unknown-linux-musl -t aarch64-unknown-linux-gnu -c rust-src -c rust-analyzer -c clippy -c rustfmt ${DOCKER_RUST_VERSION} && \
    rustup default ${DOCKER_RUST_VERSION}

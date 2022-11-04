FROM ghcr.io/galkinvv/manycross2014:main
ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-unknown-linux-gnueabi-gcc
RUN rustup-init -y --default-toolchain 1.64 -t aarch64-unknown-linux-gnu -t x86_64-pc-windows-gnu
# update cargo's crate index to cache
RUN cargo search --limit 0

FROM ghcr.io/galkinvv/manycross2014:main
RUN rustup-init -y --default-toolchain 1.64 -t aarch64-unknown-linux-gnu -t x86_64-pc-windows-gnu

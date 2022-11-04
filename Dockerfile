FROM ghcr.io/galkinvv/manycross2014:main
ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-unknown-linux-gnueabi-gcc CARGO_HOME=/cargo RUSTUP_HOME=/cargo/rustup
RUN mkdir "${RUSTUP_HOME}" && rustup-init -y --no-modify-path --default-toolchain 1.64 -t aarch64-unknown-linux-gnu -t x86_64-pc-windows-gnu
ENV PATH="/cargo/bin:${PATH}"
# update cargo's crate index to cache
RUN cargo search --limit 0

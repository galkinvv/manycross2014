FROM ghcr.io/galkinvv/manycross2014:main
# workaround for https://github.com/rust-lang/rust/issues/46651 - link to gcc (produced aarch64 musl binary is still static)
ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-unknown-linux-gnueabi-gcc CARGO_HOME=/cargo RUSTUP_HOME=/cargo/rustup CARGO_TARGET_AARCH64_UNKNOWN_LINUX_MUSL_LINKER=aarch64-unknown-linux-musl-gcc-wrap
# profile minimal is needed to avoid huge rust-docs
RUN mkdir -p "${RUSTUP_HOME}" && rustup-init -y --profile minimal --no-modify-path --default-toolchain 1.64 -t x86_64-pc-windows-gnu -t x86_64-unknown-linux-musl -t aarch64-unknown-linux-musl -t aarch64-unknown-linux-gnu -c rust-src -c rls -c rust-analyzer -c clippy -c rustfmt
ENV PATH="${CARGO_HOME}/bin:${PATH}"
RUN echo 'exec aarch64-unknown-linux-gnueabi-gcc "$@" -lgcc' > ${CARGO_HOME}/bin/aarch64-unknown-linux-musl-gcc-wrap && chmod a+x ${CARGO_HOME}/bin/aarch64-unknown-linux-musl-gcc-wrap
# update cargo's crate index to cache
RUN cargo search --limit 0

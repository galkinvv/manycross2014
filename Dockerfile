FROM ghcr.io/galkinvv/manycross2014:main
ARG DOCKER_RUST_VERSION
ENV CARGO_HOME=/cargo RUSTUP_HOME=/cargo/rustup
# profile minimal is needed to avoid huge rust-docs
RUN mkdir -p "${RUSTUP_HOME}" && rustup-init -y --profile minimal --no-modify-path --default-toolchain ${DOCKER_RUST_VERSION} -t x86_64-win7-windows-gnu -t x86_64-pc-windows-gnu -t x86_64-unknown-linux-musl -t aarch64-unknown-linux-musl -t aarch64-unknown-linux-gnu -c rust-src -c rust-analyzer -c clippy -c rustfmt
RUN echo 'exec aarch64-unknown-linux-gnueabi-gcc "$@" -lgcc' > ${CARGO_HOME}/bin/aarch64-unknown-linux-musl-gcc-wrap && echo '\
  for arg in "$@"; do\
    arg="${arg/#-lsynchronization/-lmsvcrt}";\
    arg="${arg/#rsbegin.o//cargo/rustup/toolchains/'${DOCKER_RUST_VERSION}'-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-pc-windows-gnu/lib/rsbegin.o}";\
    arg="${arg/#rsend.o//cargo/rustup/toolchains/'${DOCKER_RUST_VERSION}'-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-pc-windows-gnu/lib/rsend.o}";\
    processed_args+=("${arg}");\
  done;\
  exec /usr/bin/x86_64-w64-mingw32-gcc "${processed_args[@]}"' > ${CARGO_HOME}/bin/x86_64-w64-mingw32-gcc-win7 && \
  chmod a+x ${CARGO_HOME}/bin/*
ENV PATH="${CARGO_HOME}/bin:${PATH}"\
  CARGO_TARGET_AARCH64_UNKNOWN_LINUX_MUSL_LINKER=aarch64-unknown-linux-musl-gcc-wrap\
  CARGO_TARGET_X86_64_WIN7_WINDOWS_GNU_LINKER=x86_64-w64-mingw32-gcc-win7\
  CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-unknown-linux-gnueabi-gcc

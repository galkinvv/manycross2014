# syntax=docker/dockerfile:1.6
FROM ghcr.io/galkinvv/manycross2014:main
ARG DOCKER_RUST_VERSION
# profile minimal is needed to avoid huge rust-docs
RUN rustup toolchain install --profile minimal -t x86_64-pc-windows-gnu -t x86_64-pc-windows-gnullvm -t x86_64-unknown-linux-musl -t x86_64-unknown-linux-gnu -t aarch64-unknown-linux-musl -t aarch64-unknown-linux-gnu -c rust-src -c rust-analyzer -c clippy -c rustfmt ${DOCKER_RUST_VERSION} && \
    rustup default ${DOCKER_RUST_VERSION}
COPY --chmod=755 <<EOF ${CARGO_HOME}/bin/rlldriver-aarch64-unknown-linux-gnu-ld
#!/bin/bash
exec ${CARGO_HOME}../toolchains/${DOCKER_RUST_VERSION}-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/bin/rust-lld -flavor ld \\
    --sysroot /usr/xcc/aarch64-unknown-linux-gnu/aarch64-unknown-linux-gnu/sysroot -L =/usr/lib -L =/lib \\
    -L /usr/xcc/aarch64-unknown-linux-gnu/lib/gcc/aarch64-unknown-linux-gnu/10.3.0/ "\$@"
EOF
ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=rlldriver-aarch64-unknown-linux-gnu-ld
COPY --chmod=755 <<EOF ${CARGO_HOME}/bin/rlldriver-x86_64-w64-mingw32-ld
#!/bin/bash
exec ${CARGO_HOME}../toolchains/${DOCKER_RUST_VERSION}-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/bin/rust-lld -flavor ld \\
    -L /usr/x86_64-w64-mingw32/sys-root/mingw/lib -L /usr/lib/gcc/x86_64-w64-mingw32/4.9.3 \\
    /usr/x86_64-w64-mingw32/sys-root/mingw/lib/crt2.o "\$@"
EOF
ENV CARGO_TARGET_X86_64_PC_WINDOWS_GNU_LINKER=rlldriver-x86_64-w64-mingw32-ld
COPY --chmod=755 <<EOF ${CARGO_HOME}/bin/rlldriver-x86_64-w64-mingw32win7-ld
#!/bin/bash
for arg in "\$@"; do
    [[ "\${arg}" == "-lsynchronization" ]] && continue
    [[ "\${arg}" == "rsbegin.o" ]] || [[ "\${arg}" == "rsend.o" ]] && arg=${CARGO_HOME}../toolchains/${DOCKER_RUST_VERSION}-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-pc-windows-gnu/lib/\$arg
    processed_args+=("\${arg}")
done
exec ${CARGO_HOME}/bin/rlldriver-x86_64-w64-mingw32-ld "\${processed_args[@]}"
EOF
ENV CARGO_TARGET_X86_64_WIN7_WINDOWS_GNU_LINKER=rlldriver-x86_64-w64-mingw32win7-ld

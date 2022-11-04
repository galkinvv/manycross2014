FROM dockcross/manylinux2014-aarch64:20210925-32768e3
#unset variable targeting preferring one arch from other - this image is designed to be environment to build to any platform
ENV AUDITWHEEL_ARCH= AUDITWHEEL_PLAT= DEFAULT_DOCKCROSS_IMAGE= CROSS_TRIPLE= CROSS_ROOT= AS= AR= CC= CPP= CXX= LD= FC= CMAKE_TOOLCHAIN_FILE= CROSS_COMPILE= ARCH=
ENTRYPOINT ["/bin/bash"]
#ARG EPEL7_PRE_MINGW_REMOVE=http://mirrors.nipa.cloud/epel/7/x86_64/Packages
ARG EPEL7_PRE_MINGW_REMOVE=https://dl.fedoraproject.org/pub/archive/epel/7.2019-05-29/x86_64/Packages
RUN rpm -i $EPEL7_PRE_MINGW_REMOVE/m/mingw-binutils-generic-2.25-1.el7.x86_64.rpm $EPEL7_PRE_MINGW_REMOVE/m/mingw64-binutils-2.25-1.el7.x86_64.rpm $EPEL7_PRE_MINGW_REMOVE/m/mingw64-filesystem-101-1.el7.noarch.rpm $EPEL7_PRE_MINGW_REMOVE/m/mingw-filesystem-base-101-1.el7.noarch.rpm
RUN rpm -i $EPEL7_PRE_MINGW_REMOVE/m/mingw64-cpp-4.9.3-1.el7.x86_64.rpm $EPEL7_PRE_MINGW_REMOVE/m/mingw64-crt-4.0.4-3.el7.noarch.rpm $EPEL7_PRE_MINGW_REMOVE/m/mingw64-headers-4.0.4-5.el7.noarch.rpm $EPEL7_PRE_MINGW_REMOVE/m/mingw64-winpthreads-4.0.4-1.el7.noarch.rpm $EPEL7_PRE_MINGW_REMOVE/m/mingw64-winpthreads-static-4.0.4-1.el7.noarch.rpm
RUN rpm -i $EPEL7_PRE_MINGW_REMOVE/m/mingw64-gcc-4.9.3-1.el7.x86_64.rpm

#install rustup-init without installing rust itself
RUN curl https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init -o /usr/local/bin/rustup-init && chmod a+x /usr/local/bin/rustup-init

FROM dockcross/manylinux2014-aarch64:20210925-32768e3
ENTRYPOINT ["/bin/bash"]
#ARG EPEL7_PRE_MINGW_REMOVE=http://mirrors.nipa.cloud/epel/7/x86_64/Packages
ARG EPEL7_PRE_MINGW_REMOVE=https://dl.fedoraproject.org/pub/archive/epel/7.2019-05-29/x86_64/Packages
RUN rpm -i $EPEL7_PRE_MINGW_REMOVE/m/mingw-binutils-generic-2.25-1.el7.x86_64.rpm $EPEL7_PRE_MINGW_REMOVE/m/mingw64-binutils-2.25-1.el7.x86_64.rpm $EPEL7_PRE_MINGW_REMOVE/m/mingw64-filesystem-101-1.el7.noarch.rpm $EPEL7_PRE_MINGW_REMOVE/m/mingw-filesystem-base-101-1.el7.noarch.rpm
RUN rpm -i $EPEL7_PRE_MINGW_REMOVE/m/mingw64-cpp-4.9.3-1.el7.x86_64.rpm $EPEL7_PRE_MINGW_REMOVE/m/mingw64-crt-4.0.4-3.el7.noarch.rpm $EPEL7_PRE_MINGW_REMOVE/m/mingw64-headers-4.0.4-5.el7.noarch.rpm $EPEL7_PRE_MINGW_REMOVE/m/mingw64-winpthreads-4.0.4-1.el7.noarch.rpm $EPEL7_PRE_MINGW_REMOVE/m/mingw64-winpthreads-static-4.0.4-1.el7.noarch.rpm
RUN rpm -i $EPEL7_PRE_MINGW_REMOVE/m/mingw64-gcc-4.9.3-1.el7.x86_64.rpm

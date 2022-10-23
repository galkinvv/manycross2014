# manycross2014
single x86_64 docker image for cross-building releases for several common platforms

Based on https://github.com/dockcross/dockcross, but mostly targeted for building rust releases with dynamic linking producing binaries linked to to  old glibc versions. Unlike most of similar projects this tries to provide SINGLE docker image that targets x86_64+aarch64 linux and mingw64 windows.

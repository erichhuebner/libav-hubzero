
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir ${mkfile_path})

install: pkgdeps autoconf automake nasm x264 libav

pkgdeps:
	yum install -y cmake freetype-devel gcc gcc-c++ git libtool make mercurial pkgconfig zlib-devel

autoconf:
	cd $(mkfile_dir)/autoconf-2.69 && ./configure --prefix="/usr/local" && make && make install

automake:
	@echo $(PATH)
	cd $(mkfile_dir)/automake-1.14 && ./configure --prefix="/usr/local" && make && make install

nasm:
	cd $(mkfile_dir)/nasm-2.14.02 && ./autogen.sh && ./configure --prefix="/usr/local" && make && make install

x264:
	cd $(mkfile_dir)/x264-snapshot-20180730-2245-stable && ./configure --enable-shared --prefix="/usr/local" && make && make install

libav:
	cd $(mkfile_dir)/libav-12.3 && ./configure --extra-cflags=-I/usr/local/include --extra-ldflags=-L/usr/local/lib --enable-gpl --enable-libx264 --enable-version3 --prefix="/usr/local" && make && make install && ldconfig

all:
	@true

uninstall:
	@true

postinst:
	@true

clean:
	@true

.PHONY: all install uninstall postinst clean

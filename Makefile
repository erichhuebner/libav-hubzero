# libav install for Centos 6 and Centos 7
# Export these vars prior to installation.  Some are set permantenty in /etc/bashrc at the end of the install.
# 
# export TMPDIR=~/mytmp
# export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
# export PATH=/usr/local/bin:$PATH
# export mkdir ~/mytmp && TMPDIR=~/mytmp && export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig && export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/ && export PATH=/usr/local/bin:$PATH

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir ${mkfile_path})

install: mytmp pkgdeps autoconf automake nasm x264 libav env_vars

env_vars:
# Merge env vars with what may already be set in /etc/bashrc
#	@echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib" >> /etc/bashrc
#	@echo "PATH=/usr/local/bin:$PATH" >> /etc/bashrc
	@echo "==== Installation Complete ===="
mytmp:
	mkdir $@

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

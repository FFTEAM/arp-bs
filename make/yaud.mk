
min-prepare-yaud std-prepare-yaud max-prepare-yaud: \
%prepare-yaud:
	-rm -rf $(prefix)/$*cdkroot
	-rm -rf $(prefix)/$*cdkroot-rpmdb

#
# BOOTSTRAP
#
$(DEPDIR)/min-bootstrap $(DEPDIR)/std-bootstrap $(DEPDIR)/max-bootstrap $(DEPDIR)/bootstrap: \
$(DEPDIR)/%bootstrap: \
		%libtool \
		%$(FILESYSTEM) \
		%$(GLIBC) \
		%$(CROSS_LIBGCC) \
		%$(LIBSTDC)

	@[ "x$*" = "x" ] && touch -r RPMS/sh4/$(STLINUX)-sh4-$(LIBSTDC)-$(GCC_VERSION).sh4.rpm $@ || true

#
# BARE-OS
#
min-bare-os std-bare-os max-bare-os bare-os: \
%bare-os: \
		%bootstrap \
		%$(LIBTERMCAP) \
		%$(NCURSES_BASE) \
		%$(NCURSES) \
		%$(BASE_PASSWD) \
		%$(MAKEDEV) \
		%$(BASE_FILES) \
		%module_init_tools \
		%busybox \
		%libz \
		%grep \
		%$(INITSCRIPTS) \
		%openrdate \
		%$(NETBASE) \
		%$(BC) \
		%$(SYSVINIT) \
		%$(DISTRIBUTIONUTILS) \
		\
		%e2fsprogs \
		%u-boot-utils
#		%diverse-tools
#		%$(RELEASE) \
#		%$(FINDUTILS) \
#

min-net-utils std-net-utils max-net-utils net-utils: \
%net-utils: \
		%$(NETKIT_FTP) \
		%autofs \
		%portmap \
		%$(NFSSERVER) \
		%vsftpd \
		%ethtool \
		%opkg \
		%grep \
		%$(CIFS)

min-disk-utils std-disk-utils max-disk-utils disk-utils: \
%disk-utils: \
		%$(XFSPROGS) \
		%util-linux \
		%jfsutils \
		%$(SG3)

#dummy targets
#really ugly
min-:

std-:

max-:


#
# YAUD
#
yaud-stock: yaud-none stock
	@TUXBOX_YAUD_CUSTOMIZE@

yaud-enigma: yaud-none lirc stslave \
		boot-elf misc-cp remote firstboot enigma
	@TUXBOX_YAUD_CUSTOMIZE@
	
yaud-vdr: yaud-none stslave lirc openssl openssl-dev \
		boot-elf misc-cp remote firstboot vdr release_vdr
	@TUXBOX_YAUD_CUSTOMIZE@

yaud-neutrino: yaud-none lirc stslave \
		boot-elf remote firstboot neutrino release_neutrino
	@TUXBOX_YAUD_CUSTOMIZE@

yaud-neutrino-static: yaud-none lirc stslave \
		boot-elf remote firstboot neutrino release_neutrino_static
	@TUXBOX_YAUD_CUSTOMIZE@

yaud-neutrino-beta: yaud-none lirc stslave \
		boot-elf remote firstboot neutrino-beta release_neutrino_nightly
	@TUXBOX_YAUD_CUSTOMIZE@

yaud-neutrino-hd2: yaud-none lirc stslave \
		boot-elf remote firstboot neutrino-hd2 release_neutrino
	@TUXBOX_YAUD_CUSTOMIZE@

if STM22
yaud-enigma2: yaud-none host_python lirc stslave \
		boot-elf hotplug remote firstboot enigma2 release
	@TUXBOX_YAUD_CUSTOMIZE@
else
yaud-enigma2: yaud-none host_python lirc \
		boot-elf remote firstboot enigma2 release
	@TUXBOX_YAUD_CUSTOMIZE@
endif

if STM22
yaud-enigma2-nightly: yaud-none host_python lirc stslave \
		boot-elf hotplug remote firstboot enigma2-nightly release
	@TUXBOX_YAUD_CUSTOMIZE@
else
yaud-enigma2-nightly: yaud-none host_python lirc stslave \
		boot-elf remote firstboot enigma2-nightly release
	@TUXBOX_YAUD_CUSTOMIZE@
endif

if STM22
yaud-enigma1-hd: yaud-none lirc stslave \
		boot-elf hotplug remote firstboot enigma1-hd release_enigma1_hd
	@TUXBOX_YAUD_CUSTOMIZE@
else
yaud-enigma1-hd: yaud-none lirc stslave \
		boot-elf remote firstboot enigma1-hd release_enigma1_hd
	@TUXBOX_YAUD_CUSTOMIZE@
endif

yaud-enigma2-pli-nightly: yaud-none host_python lirc \
		boot-elf remote firstboot enigma2-pli-nightly release
	@TUXBOX_YAUD_CUSTOMIZE@

yaud-none: \
		bare-os \
		opkg-host \
		libdvdcss \
		libdvdread \
		libdvdnav \
		linux-kernel \
		net-utils \
		disk-utils \
		driver \
		init-scripts \
		udev \
		misc-tools 
	@TUXBOX_YAUD_CUSTOMIZE@

#
# MIN-YAUD
#
test-kati: min-yaud-stock

min-yaud-stock: \
%yaud-stock: %prepare-yaud %yaud-none
	@TUXBOX_YAUD_CUSTOMIZE@

min-yaud-none: \
%yaud-none:	%bare-os \
		%misc-tools \
		%linux-kernel \
		%net-utils \
		%disk-utils
	@TUXBOX_YAUD_CUSTOMIZE@
#
#min-yaud-stock: \
#%yaud-stock: min-prepare-yaud min-yaud-none
#	@TUXBOX_YAUD_CUSTOMIZE@
#
#min-yaud-none: \
#%yaud-none: %bare-os \
#		%$(RELEASE) \
#		%linux-kernel \
#		%busybox \
#		%libz \
#		%$(GREP)
#	@TUXBOX_YAUD_CUSTOMIZE@

#
# STD-YAUD
#
yaud-kati: std-yaud-stock

std-yaud-stock: \
%yaud-stock: %prepare-yaud %yaud-none %stock
	@TUXBOX_YAUD_CUSTOMIZE@

std-yaud-none: \
%yaud-none: \
		%bare-os \
		%misc-tools \
		%linux-kernel \
		%net-utils \
		%disk-utils
	@TUXBOX_YAUD_CUSTOMIZE@

#
# MAX-YAUD
#
usb-kati: max-yaud-stock

max-yaud-stock: \
%yaud-stock: %prepare-yaud %yaud-none %stock
	@TUXBOX_YAUD_CUSTOMIZE@

max-yaud-none: \
%yaud-none: \
		%bare-os \
		%misc-tools \
		%$(UDEV) \
		%$(HOTPLUG) \
		%linux-kernel \
		%net-utils \
		%disk-utils
	@TUXBOX_YAUD_CUSTOMIZE@
#
# EXTRAS
#
min-extras:usb-modeswitch \
	pppd \
	enigma2_openwebif \
	wireless_tools
	
all-extras:usb-modeswitch \
	pppd \
	evebrowser \
	enigma2-plugins \
	xupnpd \
	ntfs_3g \
	wireless_tools \
	enigma2-skins-sh4 \
	package-index

#
# FLASH IMAGE
#

flash-enigma2-pli-nightly: yaud-enigma2-pli-nightly
	echo "Create image"
	$(if $(SPARK)$(SPARK7162), \
	cd $(prefix)/../flash/spark && \
		echo -e "1\n1" | ./spark.sh \
	)
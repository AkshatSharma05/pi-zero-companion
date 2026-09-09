BUILDROOT_OUTPUT ?= $(HOME)/projects/pi-zero-output

KDIR := $(BUILDROOT_OUTPUT)/build/linux-custom  #location of Linux kernel build tree that we're building against
CROSS_COMPILE := $(BUILDROOT_OUTPUT)/host/bin/aarch64-linux-

obj-m := companion-test.o #loadable kernel modules we're building

PWD := $(CURDIR)

.PHONY: all clean #target is a command/action, not a file to create, so it is always executed and never skipped

all:
	$(MAKE) -C $(KDIR) \
		M=$(PWD) \
		ARCH=arm64 \
		CROSS_COMPILE=$(CROSS_COMPILE) \
		modules

clean:
	$(MAKE) -C $(KDIR) \
		M=$(PWD) \
		ARCH=arm64 \
		CROSS_COMPILE=$(CROSS_COMPILE) \
		clean

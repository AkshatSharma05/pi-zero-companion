.PHONY: all userspace kernel clean

all: userspace kernel

userspace:
	$(MAKE) -C userspace/companion-test

kernel:
	$(MAKE) -C kernel/companion-test

clean:
	$(MAKE) -C userspace/companion-test clean
	$(MAKE) -C kernel/companion-test clean

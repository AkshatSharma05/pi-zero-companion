BUILDROOT_OUTPUT ?= $(HOME)/projects/pi-zero-output

CC := $(BUILDROOT_OUTPUT)/host/bin/aarch64-linux-gcc

CFLAGS := -Wall -Wextra -O2

TARGET := companion-test
SOURCE := main.c

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(SOURCE)
	$(CC) $(CFLAGS) $(SOURCE) -o $(TARGET)

clean:
	rm -f $(TARGET)

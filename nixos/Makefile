#make machine=<desktop|macbook-pro>
all: link-machine-specific-files

.PHONY: link-machine-specific-files
link-machine-specific-files:
	make -C hardware link-machine-specific-files \
		prefix=$(shell pwd) \
		machine=${machine}
	make -C machine-specific link-machine-specific-files \
		prefix=$(shell pwd) \
		machine=${machine}

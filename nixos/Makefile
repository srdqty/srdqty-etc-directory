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

.PHONY: set-channel
set-channel:
	nix-channel --add https://d3g5gsiof5omrk.cloudfront.net/nixos/unstable-small/nixos-18.03pre125976.59fb55c0895 nixos
	nix-channel --update

.PHONY: print-current-nixpkgs-version
print-current-nixpkgs-version:
	echo '(import <nixpkgs> {}).lib.nixpkgsVersion' | nix-repl

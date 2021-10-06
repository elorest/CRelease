OUT_DIR=bin

all: build

build:
	@echo "Building crelease in $(shell pwd)"
	@mkdir -p $(OUT_DIR)
	@crystal build -o $(OUT_DIR)/crelease src/crelease.cr

run:
	$(OUT_DIR)/crelease

clean:
	rm -rf  $(OUT_DIR) .crystal .shards libs lib

install: build
	mkdir -p $(PREFIX)/bin
	cp ./bin/crelease $(PREFIX)/bin

link: 
	@ln -s `pwd`/bin/crelease /usr/local/bin/crelease

force_link: 
	@echo "Symlinking `pwd`/bin/crelease to /usr/local/bin/crelease"
	@ln -sf `pwd`/bin/crelease /usr/local/bin/crelease


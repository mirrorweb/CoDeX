.PHONY: build run clean
.DEFAULT: build

build:
	@csc codex.scm

run:
	@./codex

clean:
	@rm -rf codex codex.c

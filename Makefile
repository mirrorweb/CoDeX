.PHONY: build run clean
.DEFAULT: build

build:
	@csc -sJ ht.scm
	@csc -sJ codex.scm
	@csc main.scm

run:
	@./main

clean:
	@rm codex.import.scm
	@rm ht.import.scm
	@rm codex.so
	@rm ht.so
	@rm main

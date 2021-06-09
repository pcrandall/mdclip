currentDir := $(shell pwd)

build:
	@echo "==> building all platforms"
	@${currentDir}/scripts/xbuild.sh
.PHONY: build

git:
	@git add -u
	@git commit
	@git push origin
.PHONY: git

clean:
	@go clean --cache
	@go mod tidy
	@git clean -f
.PHONY: clean

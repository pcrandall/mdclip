#!/bin/bash
# Generates cross builds for all supported platforms.
#
# This script is used to build binaries for all supported platforms. Cgo is
# disabled to make sure binaries are statically linked. Appropriate flags are
# given to the go compiler to strip binaries. Current git tag is passed to the
# compiler by default to be used as the version in binaries. These are then
# compressed in an archive form (`.zip` for windows and `.tar.gz` for the rest)
# within a folder named `dist`.

set -o verbose

[ -z $version ] && version=$(git describe --tags)

mkdir -p dist/$version
dist=dist/$version

# https://golang.org/doc/install/source#environment
CGO_ENABLED=1 GOOS=darwin  GOARCH=amd64 go build -ldflags="-s -w -X main.gVersion=$version" ; \
    tar czf $dist/mdclip-$version-darwin-amd64.tar.gz mdclip LICENSE README.md; \
    file=$dist/mdclip-$version-darwin-amd64.tar.gz; \
    md5sum $file > $file.md5

CGO_ENABLED=0 GOOS=linux   GOARCH=386   go build -ldflags="-s -w -X main.gVersion=$version" ; \
    tar czf $dist/mdclip-$version-linux-386.tar.gz    mdclip LICENSE README.md; \
    file=$dist/mdclip-$version-linux-386.tar.gz; \
    md5sum $file > $file.md5

CGO_ENABLED=0 GOOS=linux   GOARCH=amd64 go build -ldflags="-s -w -X main.gVersion=$version" ; \
    tar czf $dist/mdclip-$version-linux-amd64.tar.gz  mdclip LICENSE README.md; \
    file=$dist/mdclip-$version-linux-amd64.tar.gz; \
    md5sum $file > $file.md5

CGO_ENABLED=0 GOOS=windows GOARCH=386   go build -ldflags="-s -w -X main.gVersion=$version" ; \
    zip $dist/mdclip-$version-windows-386.zip   mdclip.exe LICENSE README.md; \
    file=$dist/mdclip-$version-windows-386.zip; \
    md5sum $file > $file.md5

CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -ldflags="-s -w -X main.gVersion=$version" ; \
    zip $dist/mdclip-$version-windows-amd64.zip mdclip.exe LICENSE README.md; \
    file=$dist/mdclip-$version-windows-amd64.zip; \
    md5sum $file > $file.md5

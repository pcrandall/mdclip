package main

import (
	"encoding/base64"
	"fmt"
	"os"

	"golang.design/x/clipboard"
)

func main() {
	encoded := clipboard.Read(clipboard.FmtImage)
	if len(encoded) < 1 {
		fmt.Println("No image in clipboard!")
		os.Exit(1)
	}
	e := base64.StdEncoding.EncodeToString(encoded)
	str := "![...](data:image/png;base64," + e + ")"
	clipboard.Write(clipboard.FmtText, []byte(str))
}

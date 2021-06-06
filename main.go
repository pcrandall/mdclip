package main

import (
	"encoding/base64"
	"fmt"
	"os"
	"time"

	"golang.design/x/clipboard"
)

func main() {
	readClipboard := clipboard.Read(clipboard.FmtImage)
	if len(readClipboard) < 1 {
		clipboard.Write(clipboard.FmtText, []byte("No image in clipboard!"))
		return
	}
	encodedString := base64.StdEncoding.EncodeToString(readClipboard)
	unixTimestamp := time.Now().Unix()

	str := "![img_" + fmt.Sprintf("%d", unixTimestamp) + "](data:image/png;base64," + encodedString + ")"
	clipboard.Write(clipboard.FmtText, []byte(str))

	b := clipboard.Read(clipboard.FmtText)
	for len(b) > 0 {
		n, err := os.Stdout.Write(b)
		if err != nil {
			println("oops")
			return
		}
		b = b[n:]
	}
	println("\033[H")
}

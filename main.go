package main

import (
	"encoding/base64"
	"fmt"
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
}

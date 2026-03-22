package op

import "core:fmt"
import "core:terminal/ansi"

main :: proc() {
    colorized : string
    colorized = colorize("Hej med färg!")
    fmt.println(colorized)
}

/*
I Odin måste du själv hålla ordning på minnet.
vad har returvärdet för livscykel?
*/
colorize :: proc(message: string) -> string {
    return fmt.aprintf("%s", message)
}


























/*
"One of my favourite things about Go is the defer statement." -
https://www.gingerbill.org/article/2015/08/19/defer-in-cpp/
*/
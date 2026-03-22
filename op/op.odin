package op

import "core:fmt"
import "core:terminal/ansi"

main :: proc() {
    colorized := colorize("Hej med färg!")
    defer delete(colorized)
    fmt.println(colorized)
}

colorize :: proc(message: string, allocator := context.allocator) -> string {
    c := fmt.aprintf(
        "%s%s%s",
        ansi.CSI + ansi.FG_CYAN + ansi.SGR,
        message,
        ansi.CSI + ansi.RESET + ansi.SGR,
        allocator = allocator
    )
    // defer delete(c)
    return fmt.aprintf("%s", c, allocator = allocator)
}
























/*
"One of my favourite things about Go is the defer statement." -
https://www.gingerbill.org/article/2015/08/19/defer-in-cpp/
*/
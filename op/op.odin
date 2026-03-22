package op

import "core:fmt"
import "core:terminal/ansi"

Color :: enum {
    BLACK,
    RED,
    GREEN,
    YELLOW,
    BLUE,
    MAGENTA,
    CYAN,
    WHITE,
}

// https://odin-lang.org/docs/overview/#enumerated-array
AnsiColors :: [Color]string {
    .BLACK      = ansi.FG_BLACK,
    .RED        = ansi.FG_RED,
    .GREEN      = ansi.FG_GREEN,
    .YELLOW     = ansi.FG_YELLOW,
    .BLUE       = ansi.FG_BLUE,
    .MAGENTA    = ansi.FG_MAGENTA,
    .CYAN       = ansi.FG_CYAN,
    .WHITE      = ansi.FG_WHITE,
}

main :: proc() {
    colorized := colorize("Hej med färg!", fg_color = .RED)
    defer delete(colorized)
    fmt.println(colorized)
}

colorize :: proc(message: string, fg_color := Color.WHITE, bg_color := Color.BLUE) -> string {

    // Quiz!!! Varför funkar det inte?
    colorStr := AnsiColors[fg_color]

    c := fmt.aprintf(
    "%s%s%s%s%s",
    ansi.CSI,
    colorStr,
    ansi.SGR,
    message,
    ansi.CSI + ansi.RESET + ansi.SGR,
    )
    defer delete(c)
    return fmt.aprintf("%s", c)
}
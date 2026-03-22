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
AnsiColors :: [Color][2]string {
    .BLACK      = { ansi.FG_BLACK, ansi.BG_BLACK },
    .RED        = { ansi.FG_RED, ansi.BG_RED },
    .GREEN      = { ansi.FG_GREEN, ansi.BG_GREEN },
    .YELLOW     = { ansi.FG_YELLOW, ansi.BG_YELLOW },
    .BLUE       = { ansi.FG_BLUE, ansi.BG_BLUE },
    .MAGENTA    = { ansi.FG_MAGENTA, ansi.BG_MAGENTA },
    .CYAN       = { ansi.FG_CYAN, ansi.BG_CYAN },
    .WHITE      = { ansi.FG_WHITE, ansi.BG_WHITE },
}

@(rodata)
ansiColors := AnsiColors

main :: proc() {
    colorized := colorize("Hej med färg!", fg_color = .YELLOW, bg_color = .BLACK)
    defer delete(colorized)
    fmt.println(colorized)
}

colorize :: proc(
message: string,
fg_color := Color.WHITE,
bg_color := Color.BLUE
) -> string {

    c := fmt.aprintf(
    "%s%s%s%s%s%s%s%s",
    ansi.CSI,
    ansiColors[fg_color][0],
    ansi.SGR,
    ansi.CSI,
    ansiColors[bg_color][1],
    ansi.SGR,
    message,
    ansi.CSI + ansi.RESET + ansi.SGR,
    )
    defer delete(c)
    return fmt.aprintf("%s", c)
}
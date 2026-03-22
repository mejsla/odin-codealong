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

main :: proc() {
    colorized := colorize("Hej med färg!", color = .RED)
    defer delete(colorized)
    fmt.println(colorized)
}

colorize :: proc(message: string, color : Color = Color.WHITE, allocator := context.allocator) -> string {
    colorStr : string

    switch color {
    case .BLACK: colorStr = ansi.FG_BLACK
    case .RED: colorStr = ansi.FG_RED
    case .GREEN: colorStr = ansi.FG_GREEN
    case .YELLOW: colorStr = ansi.FG_YELLOW
    case .BLUE: colorStr = ansi.FG_BLUE
    case .MAGENTA: colorStr = ansi.FG_MAGENTA
    case .CYAN: colorStr = ansi.FG_CYAN
    case .WHITE: colorStr = ansi.FG_WHITE
    }

    c := fmt.aprintf(
    "%s%s%s%s%s",
    ansi.CSI,
    colorStr,
    ansi.SGR,
    message,
    ansi.CSI + ansi.RESET + ansi.SGR,
    allocator = allocator
    )
    defer delete(c)
    return fmt.aprintf("%s", c, allocator = allocator)
}
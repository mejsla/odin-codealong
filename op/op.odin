package op

import "core:fmt"
import "core:strings"
import "core:terminal/ansi"
import "core:unicode/utf8"

main :: proc() {
    colorizedText := style("Hej [blue]från [green]Odin")
    fmt.println(colorizedText)
    free_all(context.temp_allocator)
}


Color :: enum {
    BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE,
}

ColorCodes :: [Color][2]string {
    .BLACK = { ansi.FG_BLACK, ansi.BG_BLACK },
    .RED = { ansi.FG_RED, ansi.BG_RED },
    .GREEN = { ansi.FG_GREEN, ansi.BG_GREEN },
    .YELLOW = { ansi.FG_YELLOW, ansi.BG_YELLOW },
    .BLUE = { ansi.FG_BLUE, ansi.BG_BLUE },
    .MAGENTA = { ansi.FG_MAGENTA, ansi.BG_MAGENTA },
    .CYAN = { ansi.FG_CYAN, ansi.BG_CYAN },
    .WHITE = { ansi.FG_WHITE, ansi.BG_WHITE },
}

@rodata
colorCodes := ColorCodes

colorize :: proc(message: string, fg:=Color.WHITE, bg:=Color.BLUE) -> string {
    return fmt.tprintf(
    "%s%s%s%s%s%s%s", ansi.CSI, colorCodes[fg][0], ansi.SGR + ansi.CSI, colorCodes[bg][1], ansi.SGR, message, ansi.CSI + ansi.RESET + ansi.SGR
    )
}

TextToken :: struct {
    text: string
}

ColorToken :: struct {
    isForeground: bool, color: Color
}

Token :: union {
    TextToken, ColorToken,
}

style :: proc(markup: string) -> string {
    error, tokens := parse(markup)
    if (error != "") {
        return colorize(fmt.tprintln("PARSE ERROR:", error), fg=.BLACK, bg=.RED)
    }
    builder := strings.builder_make(context.temp_allocator)
    defer strings.builder_destroy(&builder)
    currentColorToken := ColorToken { color = .BLACK }
    for token in tokens {
        switch t in token {
        case ColorToken:
            currentColorToken = t
        case TextToken:
            colorText := colorize(t.text, currentColorToken.color, bg=.WHITE)
            strings.write_string(&builder, colorText)
        }
    }
    return strings.clone(strings.to_string(builder))
}

parse :: proc(markup: string) -> (errors: string, tokens: [dynamic]Token) {
    resultTokens : [dynamic]Token
    resultTokens.allocator = context.temp_allocator
    runes :=  utf8.string_to_runes(markup, context.temp_allocator)
    numRunes := len(runes)
    index := 0
    readingColorToken := false
    currentTokenBuffer : [dynamic]rune
    currentTokenBuffer.allocator = context.temp_allocator

    for index < numRunes {
        if readingColorToken {
            if runes[index] == ']' {
                readingColorToken = false
                index += 1
                colorName := utf8.runes_to_string(currentTokenBuffer[:], context.temp_allocator)
                color, ok := parseColorString(colorName)
                if ok {
                    append(&resultTokens, ColorToken { isForeground = true, color = color })
                } else {
                    errors = fmt.tprintf("Unknown color code: '%s'", colorName)
                    return errors, resultTokens
                }
                clear(&currentTokenBuffer)
            } else {
                append(&currentTokenBuffer, runes[index])
                index += 1
            }
        } else {
            if runes[index] == '[' {
                index += 1
                if runes[index] == '[' {
                // Escaped [[ so we will just remember one [ and keep reading as text
                    append(&currentTokenBuffer, runes[index])
                    index += 1
                } else {
                    readingColorToken = true
                    if (len(currentTokenBuffer) > 0) {
                        append(&resultTokens, TextToken { text = utf8.runes_to_string(currentTokenBuffer[:], context.temp_allocator) })
                        clear(&currentTokenBuffer)
                    }
                }
            } else {
                append(&currentTokenBuffer, runes[index])
                index += 1
            }
        }
    }
    if (len(currentTokenBuffer) > 0) {
        if readingColorToken {
            errors = "Unterminated color code at end of string"
        } else {
            append(&resultTokens, TextToken { text = utf8.runes_to_string(currentTokenBuffer[:], context.temp_allocator) })
        }
    }
    return errors, resultTokens
}

parseColorString :: proc(colorName:string) -> (color: Color, ok: bool) {
    normalizedColorString := strings.to_lower(colorName, context.temp_allocator)
    ok = true
    switch normalizedColorString {
    case "black":
        color = .BLACK
    case "red":
        color = .RED
    case "green":
        color = .GREEN
    case "yellow":
        color = .YELLOW
    case "blue":
        color = .BLUE
    case "magenta":
        color = .MAGENTA
    case "cyan":
        color = .CYAN
    case "white":
        color = .WHITE
    case :
        ok = false
    }
    return color, ok
}
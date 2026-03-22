package tests
import "core:testing"
import "../op"

@(test)
blackParseTest :: proc(t: ^testing.T) {
    assertExpectedColor(t, "bLaCk", op.Color.BLACK)
}

@(test)
redParseTest :: proc(t: ^testing.T) {
    assertExpectedColor(t, "red", op.Color.RED)
}

@(test)
greenParseTest :: proc(t: ^testing.T) {
    assertExpectedColor(t, "GREEN", op.Color.GREEN)
}

@(test)
yellowParseTest :: proc(t: ^testing.T) {
    assertExpectedColor(t, "Yellow", op.Color.YELLOW)
}

@(test)
blueParseTest :: proc(t: ^testing.T) {
    assertExpectedColor(t, "blue", op.Color.BLUE)
}

@(test)
magentaParseTest :: proc(t: ^testing.T) {
    assertExpectedColor(t, "magenta", op.Color.MAGENTA)
}

@(test)
cyanParseTest :: proc(t: ^testing.T) {
    assertExpectedColor(t, "cyAN", op.Color.CYAN)
}

@(test)
whiteParseTest :: proc(t: ^testing.T) {
    assertExpectedColor(t, "WHITE", op.Color.WHITE)
}

@(test)
unknownColorTest :: proc(t: ^testing.T) {
    color, ok := op.parseColorString("foo")
    testing.expect(t, !ok, "Unkown color should not be ok")
}

@(test)
emptyColorTest :: proc(t: ^testing.T) {
    color, ok := op.parseColorString("")
    testing.expect(t, !ok, "Unkown color should not be ok")
}

assertExpectedColor :: proc(t: ^testing.T, colorName: string, expected:op.Color) {
    color, ok := op.parseColorString(colorName)
    testing.expect(t, ok, "Expected OK parse")
    testing.expect(t, color == expected, "Unexpected color value")
}


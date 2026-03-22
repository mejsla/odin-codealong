package tests

import "../op"
import "core:testing"

@(test)
emptyStringParseTest :: proc(t: ^testing.T) {
    errors, tokens := op.parse("")
    testing.expect(t, len(tokens) == 0, "Expected no tokens")
    testing.expect(t, errors == "", "Expected error message to be an empty string")
}

@(test)
onlyColorNoMessageParseTest :: proc(t: ^testing.T) {
    errors, tokens := op.parse("[black]")
    numTokens := len(tokens)
    testing.expect(t, errors == "", "Expected error message to be an empty string")
    testing.expect(t, numTokens == 1, "Expected a single token")
    #partial switch token in tokens[0] {
    case op.ColorToken:
        testing.expectf(t, token.color == .BLACK, "Unexpected color '%s'", token.color)
    case :
        testing.fail_now(t, "Unexpected token type")
    }
}

@(test)
textPrefixAndSuffixTest :: proc(t: ^testing.T) {
    errors, tokens := op.parse("foo[black]bar")
    numTokens := len(tokens)
    testing.expectf(t, errors == "", "Expected error message to be an empty string, was '%s'", errors)
    testing.expectf(t, numTokens == 3, "Unexpected number of tokens, was '%d'", numTokens)
    #partial switch token in tokens[0] {
    case op.TextToken:
        testing.expect(t, token.text == "foo", "Unexpected text")
    case :
        testing.fail_now(t, "Unexpected token type")
    }
    #partial switch token in tokens[1] {
    case op.ColorToken:
        testing.expectf(t, token.color == .BLACK, "Unexpected color '%s'", token.color)
    case :
        testing.fail_now(t, "Unexpected token type")
    }
    #partial switch token in tokens[2] {
    case op.TextToken:
        testing.expect(t, token.text == "bar", "Unexpected text")
    case :
        testing.fail_now(t, "Unexpected token type")
    }
}

@(test)
unterminatedColorCodeTest :: proc(t: ^testing.T) {
    errors, tokens := op.parse("foo[black")
    testing.expect(t, errors == "Unterminated color code at end of string", "Expected error message to be 'Unterminated color code at end of string'")
}

@(test)
escapedBracketTest :: proc(t: ^testing.T) {
    errors, tokens := op.parse("foo[[black]bar")
    testing.expect(t, errors == "", "Expected error message to be ''")
    numTokens := len(tokens)
    testing.expect(t, numTokens == 1, "Unexpected number of tokens")
    #partial switch token in tokens[0] {
    case op.TextToken:
        testing.expect(t, token.text == "foo[black]bar", "Unexpected text")
    case :
        testing.fail_now(t, "Unexpected token type")
    }
}

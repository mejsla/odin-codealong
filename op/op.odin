package op
// Package styrs _inte_ av katalognamnet

import "core:fmt"
// Importer är bara kataloger

main :: proc() {
    // Ja main är då en procedure :-O
    // Odin har inte tid med "side effect free functions vs, procedures"
    // för Odin försöker få jobbet gjort.
    fmt.println("Hej från Odin")
}

/*
Bygg med: odin build op
Kör med: odin run op
*/
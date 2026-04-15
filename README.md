# Odin Code-A-Long

Hej kamrater.

Här är förberedelserna för er som vill hänga med. Det är en del att göra så dra igång kaffebryggaren nu.

## Repo

Klona det är repositoryt. Det innehåller lite exempelkod som jag tänkte gå igenom på dragningen.

# Installera Odin

Här finns den officiella beskrivningen https://odin-lang.org/docs/install/

OBS denna Code-A-Long använder Odin version `dev-2026-03` 

Jag har bara använt "from source" på Linux. Om ni vill göra på något annat sätt så fyll gärna på med tips & tricks här (PR välkomna).

## På Mac

[Petter har skrivit bra instruktioner](SETUP-MAC.md)

## Från källkod på Linux

### LLVM

Installera:
* LLVM
* LLVM-Config
* CLang

Det brukar finnas färdiga paket oavsett distribution. Jag använder LLVM version 21

Bonus men bra att ha är en debugger, jag kör:
* LLDB
* LLDB-DAP

På Fedora så kom dom två binärerna i samma paket.

### Klona Odin

`git clone https://github.com/odin-lang/Odin`

`cd Odin`

`git checkout dev-2026-03` 

`./build_odin.sh release-native`

# Editor

## Jetbrains

Jag har använt en Odin plugin till Jetbrains produkter. 

EDIT: ~~Tyvärr så slutade den att funka med senare version av Jetbrains IDÉer~~ 

Den är uppdaterad och funkar nu i 2026.1 av Jetbrains produkter.

https://plugins.jetbrains.com/plugin/22933-odin-support

## Odin Language Server

Editorer som använder LSP behöver Odin Language Server. Den funkar helt OK och har instruktioner för VSCode, Sublime, Vim, Emacs o.s.v

https://github.com/DanielGavin/ols

Den är förstås skriven i Odin så det är ju ett bra sätt att se om din odin kan kompilera ols :-)

Det är den jag själv använder i [VSCodium](https://vscodium.com) 


*Nu är ni klara, vi ses på Code-A-Long!*


# Närodlat

Svensk programvara som kan vara kul att känna till.

## Understanding the Odin Programming Language

Det råkar sig så att en herre vid namn [Karl Zylinski](https://zylinski.se) skrivit en bok om Odin som jag tycker är bra. Köp den :-) (obs jag känner inte Karl men puffar för den ändå).

## gram

[gram](https://gram.liten.app) är en fork av Zed Editorn som jag försöker använda för Odin men har för tillfället inte riktigt lyckats sy ihop ols med den. Säkert något enkelt jag gör fel.
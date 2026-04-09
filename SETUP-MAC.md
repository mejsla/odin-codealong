# Setup på Mac

### Odin

- Laddade från https://github.com/odin-lang/Odin/releases#:~:text=Assets (Jag föll för `odin-macos-arm64-dev-2026-04.tar.gz`)
- Packade upp, och lade till directoryt med odin-binären i `PATH`

### LLVM

Installera med

```bash:
brew install llvm
```

Detta tror jag gav mig allt vad som behövs (LLVM, llvm-config, Clang och LLDB).

I slutet av installationen kom en instruktion om att lägga till LLVM i `PATH`, nåt i stil med:

```bash:
echo 'export PATH="/opt/homebrew/opt/llvm/bin:$PATH"' >> /path/to/.bash_profile
```

&mdash; but your profile may vary.

### Köra det tomma programmet

Stå i detta repos rot och kör:

```bash:
odin run op/
```

Då fick jag ett fel pga. att min nedladdade odins `/libs/libLLVM.dylib` var farligt (nedladdat från internet).
Jag bestämde mig för att det var ofarligt (TM) att ta allt i den nedladdade nightlyn "ur karantän":

```bash:
xattr -rd com.apple.quarantine path/till/nedladdat/och/upp-packat/odin-directory/
```

Efter det kunde jag få ut `Hello, Maasing!` på skärmen:

Filen _./op/op.odin_ varsamt redigerad till:

```odin
package op

import "core:fmt"

main :: proc() {
    fmt.println("Hello, Maasing!")
}
```

och körande

```bash:
    odin run op/
```

/Petter

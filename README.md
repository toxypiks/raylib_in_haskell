#### Usage

`ghci -I./usr/include/ -L./usr/lib/ -lraylib Main.hs`

open raylib window from ghci:

`newCString "Hello" >>= initWindow 800 600`

compiling Main.hs with ghc

`ghc -I./usr/include/ -L./usr/lib/ -lraylib -dynamic Main.hs`

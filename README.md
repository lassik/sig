# Generic file format signature

## Scheme

    $ chibi-scheme
    > (import (sig))
    > (with-output-to-file "example.bin"
        (lambda () (sig-write "example.com/format#2020")))
    "example.com/format#2020"
    > (with-input-from-file "example.bin" sig-read)
    "example.com/format#2020"

## file(1)

    $ file -m sig.magic example.bin
    example.bin: binary format: example.com/format#2020

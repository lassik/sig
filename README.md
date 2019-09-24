# Generic file format signature

## Scheme

    $ chibi-scheme
    > (import (sig))
    > (with-output-to-file "example.bin" (lambda () (sig-write "com.example.format")))
    "com.example.format"
    > (with-input-from-file "example.bin" sig-read)
    "com.example.format"

## file(1)

    $ file -m sig.magic example.bin
    example.bin: our thing: com.example.format

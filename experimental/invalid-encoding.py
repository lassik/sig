#! /usr/bin/env python3


def ensure_invalid_with_encoding(encoding, bytes_):
    try:
        bytes_.decode(encoding=encoding, errors="strict")
    except UnicodeDecodeError:
        pass
    else:
        raise Exception("Did not cause an error: {}".format(repr(encoding)))


for encoding in ["UTF-8", "UTF-16-BE", "UTF-16-LE", "UTF-32-BE", "UTF-32-LE"]:
    ensure_invalid_with_encoding(encoding, b"\xDC\xDC\x00\x0D")

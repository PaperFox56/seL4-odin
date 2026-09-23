#!/bin/env python

def translate_preprocessor_line(line: str):
    out = ""

    words = line.split()
    assert words[0].strip() == "#define"

    name = words[1].strip()
    value = words[2].strip()

    if not value.isnumeric():
        value = f'"{value}"'

    out = f'{name}\t:: {value}'

    return out


def translate_file(content: str):
    result_file = "/* generated with Python from a C header */"
    empty = 0

    for line in content.splitlines():
        if line.startswith("#define"):
            if empty > 0:
                result_file += "\n"
                empty = 0
            out = translate_preprocessor_line(line)
            result_file += "\n" + out
        else:
            empty += 1

    return result_file

if __name__ == "__main__":
    import sys
    content = ""
    if len(sys.argv) > 1:
        with open(sys.argv[1]) as file:
            content = file.read()
            file.close()
    else:
        content = sys.stdin.read()
    print(translate_file(content))

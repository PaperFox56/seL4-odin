This is by no mean usable for now, I'll put proper usage instructuctions once I get something working.

Last SeL4 version supported: 16.0.0

# Notes
If using the provided crt files, the entry point of the program should be an exposed `_seL4_entry` function.
If the thread if the root thread, the function should take a `^seL4.BootInfo` as first argument.

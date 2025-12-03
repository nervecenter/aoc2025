import std/math
import std/strutils
import std/sequtils

proc combine_digits(d1, d2: char): int = parse_int(d1 & d2)

proc process_bank(bank: string): int =
    var
        lookahead = 3
        joltage_str = ""
        i = 0

    while i + lookahead < bank.len:
        let
            window = bank[i ..< i + lookahead]
            window_max_idx = window.max_index()
            window_max_char = window[window_max_idx]
        echo window
        lookahead -= window_max_idx
        joltage_str.add window_max_char
        i += window_max_idx + 1
        if joltage_str.len == 12:
            break
    echo joltage_str
    return joltage_str.parse_int()


let banks = read_file("day3_test_input.txt").split_lines()

var bank_joltages: seq[int] = @[]

for bank in banks:
    bank_joltages.add process_bank(bank)

echo bank_joltages.sum()

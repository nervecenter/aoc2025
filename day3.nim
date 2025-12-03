import std/math
import std/strutils

proc combine_digits(d1, d2: char): int = parse_int(d1 & d2)

let banks = read_file("day3_input.txt").split_lines()

var
    highest_jolts: array[2, char] = ['0', '0']
    bank_joltages: seq[int] = @[]

for bank in banks:
    for b1 in 0 ..< bank.len - 1:
        for b2 in b1 + 1 ..< bank.len:
            if combine_digits(highest_jolts[0], highest_jolts[1]) < combine_digits(bank[b1], bank[b2]):
                highest_jolts[0] = bank[b1]
                highest_jolts[1] = bank[b2]
    bank_joltages.add combine_digits(highest_jolts[0], highest_jolts[1])
    highest_jolts[0] = '0'
    highest_jolts[1] = '0'

echo bank_joltages.sum()

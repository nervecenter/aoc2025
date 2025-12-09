import std/math
import std/sugar
import std/strutils
import std/sequtils

# proc combine_digits(d1, d2: char): int = parse_int(d1 & d2)

# proc process_bank(bank: string): int =
#     var
#         lookahead = 3
#         joltage_str = ""
#         i = 0

#     while i + lookahead < bank.len:
#         let
#             window = bank[i ..< i + lookahead]
#             window_max_idx = window.max_index()
#             window_max_char = window[window_max_idx]
#         echo window
#         lookahead -= window_max_idx
#         joltage_str.add window_max_char
#         i += window_max_idx + 1
#         if joltage_str.len == 12:
#             break
#     echo joltage_str
#     return joltage_str.parse_int()

proc make_joltage(bank: string, positions: array[12, int]): int =
    result = positions.map(p => bank[p]).join().parse_int()

proc iterate_bank(bank: string, bdx: int, highest_jolts: int): int =
    for 
        if bdx = 11:
            let joltage = make_joltage(bank, positions)
            if joltage > highest_jolts:
                return joltage
        else:
            return iterate_bank


proc process_bank(bank: string): int =
    var
        positions: array[12, int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
        to_move = 11
        joltage: int
    result = 0

    # for least_pos in countdown(11, to_move):
    #     for i in least_pos ..< 12:
    #         let bank_stop = 11 - i
    #         for j in positions[i] ..< bank.len - bank_stop:
    #             positions[j] += 1
    #             joltage = make_joltage(bank, positions)
    #             if joltage > result:
    #                 result = joltage
    #         positions[i] += 1
    #         positions[j] = positions[i] + 1

    for j in first_mover ..< 12:
        let start_battery = positions[j]
        for i in start_battery ..< bank.len - 11 + j:
            positions[j] = i
            joltage = make_joltage(bank, positions)


    echo "Found max joltage " & $result


let banks = read_file("day3_test_input.txt").split_lines()

var bank_joltages: seq[int] = @[]

for bank in banks:
    bank_joltages.add process_bank(bank)

echo bank_joltages.sum()

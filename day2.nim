import std/math
import std/sugar
import std/sequtils
import std/strutils


proc pair_seq_to_tuple(pair_seq: seq[int]): (int, int) =
    assert pair_seq.len == 2
    return (pair_seq[0], pair_seq[1])


let
    day2_input = read_file("day2_input.txt")
    id_ranges = day2_input.split(",").map(p => p.split("-").map(n => n.parse_int()).pair_seq_to_tuple())

var invalids: seq[int] = @[]


for (start, finish) in id_ranges:
    for id in start .. finish:
        let id_str = $id

        if id_str.len mod 2 == 0:
            let half_len = id_str.len div 2
            let first_half = id_str[0 ..< half_len]
            let second_half = id_str[half_len .. ^1]

            if first_half == second_half:
                invalids.add id

echo invalids.sum()

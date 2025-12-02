import std/math
import std/sugar
import std/sequtils
import std/strutils


proc pair_seq_to_tuple(pair_seq: seq[int]): (int, int) =
    assert pair_seq.len == 2
    return (pair_seq[0], pair_seq[1])

proc partition(source: string, part_length: int): seq[string] =
    assert source.len mod part_length == 0
    let num_parts = source.len div part_length
    for c in countup(0, part_length * num_parts - 1, part_length):
        result.add source[c ..< c + part_length]

let
    day2_input = read_file("day2_input.txt")
    id_ranges = day2_input.split(",").map(p => p.split("-").map(n => n.parse_int()).pair_seq_to_tuple())

var invalids: seq[int] = @[]

for (start, finish) in id_ranges:
    for id in start .. finish:
        let id_str = $id

        for part_len in countdown(id_str.len div 2, 1):
            if id_str.len mod part_len != 0:
                continue
            let parts = id_str.partition(part_len)
            if parts.all(p => p == parts[0]):
                invalids.add id
                break

echo invalids.sum()

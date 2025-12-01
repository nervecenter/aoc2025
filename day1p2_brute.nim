import std/strutils


type LockState = object
    lock_val: int = 50
    times_at_0: int = 0


let day1_input = read_file("day1_input.txt")

proc parse_rotation(rotation: string): int =
    let num = rotation[1..^1].parse_int()
    return
        if rotation[0] == 'L':  num * -1
        else:                   return num

proc turn_lock(lock_state: var LockState, rotation: int) =
    if rotation < 0:
        for tic in rotation ..< 0:
            lock_state.lock_val -= 1
            if lock_state.lock_val == 0:
                lock_state.times_at_0 += 1
            if lock_state.lock_val == -1:
                lock_state.lock_val = 99
    else:
        for tic in 0 ..< rotation:
            lock_state.lock_val += 1
            if lock_state.lock_val == 100:
                lock_state.lock_val = 0
                lock_state.times_at_0 += 1

var lock_state = LockState()

for line in day1_input.splitlines():
    lock_state.turn_lock(parse_rotation(line))

echo "Times at 0: " & $lock_state.times_at_0
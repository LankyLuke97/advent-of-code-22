from pathlib import Path
from time import perf_counter

def load_input(test=False, file_path=None):
    file_path = Path(f'day11', 'data', f'{"test" if test else "input"}.txt') if not file_path else file_path
    with open(file_path, 'r') as f:
        return [line.strip() for line in f.readlines() if line.strip()]

def part1(test=False, file_path=None):
    inp = [(int(i),i) for line in load_input(test, file_path)for i in line.split()]
    start_time = perf_counter()

    for _ in range(25):
        new_inp = []
        for i, str_rep in inp:
            if i == 0: new_inp.append((1, '1'))
            elif len(str(str_rep)) % 2 == 0:
                first_half = int(str_rep[:int(len(str_rep)/2)])
                second_half = int(str_rep[int(len(str_rep)/2):])
                new_inp.append((first_half,str(first_half)))
                new_inp.append((second_half,str(second_half)))
            else: new_inp.append((i * 2024, str(i*2024)))
        inp = new_inp

    end_time = perf_counter()
    return len(inp), end_time - start_time

def part2(test=False, file_path=None):
    # inp = load_input(test, file_path)
    start_time = perf_counter()

    end_time = perf_counter()
    return 0, end_time - start_time

test1_correct = 55312
test2_correct = 0
test, _ = part1(test=True)
assert test == test1_correct, f'Part 1 test failed; it returned {test} instead of {test1_correct}'
part1_ans, part1_time = part1()
print(f'Part 1 answer is: {part1_ans}, returned in {part1_time * 1000:.3f} ms')
test, _ = part2(test=True)
assert test == test2_correct, f'Part 2 test failed; it returned {test} instead of {test2_correct}'
part2_ans, part2_time = part2()
print(f'Part 2 answer is: {part2_ans}, returned in {part2_time * 1000:.3f} ms')
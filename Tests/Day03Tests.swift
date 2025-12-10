import Testing

@testable import aoc

private let testInput = """
    987654321111111
    811111111111119
    234234234234278
    818181911112111
    """
@Suite("Day 3 Tests")
struct Day03Tests {
    @Test("Day 3 Part 1", .tags(.testInput))
    func testDay03_part1() async {
        let day = Day03(input: testInput)
        await #expect(day.part1() == 357)
    }

    @Test("Day 3 Part 1 Solution")
    func testDay03_part1_solution() async {
        let day = Day03(input: Day03.input)
        await #expect(day.part1() == 16842)
    }

    @Test("Day 3 Part 2", .tags(.testInput))
    func testDay03_part2() async {
        let day = Day03(input: testInput)
        await #expect(day.part2() == 3_121_910_778_619)
    }

    @Test("Day 3 Part 2 Solution")
    func testDay03_part2_solution() async {
        let day = Day03(input: Day03.input)
        await #expect(day.part2() == 167_523_425_665_348)
    }
}

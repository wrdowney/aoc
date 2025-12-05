//
//  File.swift
//  aoc
//
//  Created by Will D on 12/5/25.
//

public protocol AdventOfCodeDay: Sendable {
    static var input: String { get }

    var day: String { get }
    var title: String { get }

    init(input: String)

    func run() async

    associatedtype Solution1
    func part1() async -> Solution1

    associatedtype Solution2
    func part2() async -> Solution2
}

extension AdventOfCodeDay {
    public static var input: String { "" }
    public var day: String { "\(Int("\(Self.self)".suffix(2))!)" }

    public func run() async {
        await run(part: 1, part1)
        await run(part: 2, part2)
    }

    private func run<T>(part: Int, _ fun: () async -> T) async {
        let solution = await fun()
        print("Solution for day \(day) '\(title)' part \(part): \(solution)")
    }
}

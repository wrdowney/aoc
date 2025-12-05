//
//  File.swift
//  aoc
//
//  Created by Will D on 12/5/25.
//

import Foundation


extension String {
    public var lines: [String] {
        split(omittingEmptySubsequences: false, whereSeparator: \.isNewline).map { String($0) }
    }
}

//
//  Todo+Extensions.swift
//  Todo
//
//  Created by 登秝吳 on 01/07/2020.
//

import Foundation

extension Todo: Identifiable {}
extension Todo: Equatable {
    public static func ==(lhs: Todo, rhs: Todo) -> Bool {
        lhs.id == rhs.id && lhs.body == rhs.body
    }
}
extension Todo: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id + body)
    }
}

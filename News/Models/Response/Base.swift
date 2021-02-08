//
//  Base.swift
//  News
//
//  Created by Armenuhi Mkrtchyan on 2/2/21.
//

struct Base <T: Codable>: Codable {
    let success: Bool
    let metadata: T?
}

//
//  Option.swift
//  SeedlingMacOSTest
//
//  Created by Vincenzo Gerelli on 16/10/25.
//


import Foundation

/// Represents a single selectable option within a multiple-choice question.
struct Option: Identifiable, Hashable, Codable {
    var id = UUID()
    var text: String = ""
}

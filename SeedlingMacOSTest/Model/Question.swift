//
//  QuestionType.swift
//  SeedlingMacOSTest
//
//  Created by Vincenzo Gerelli on 16/10/25.
//


import Foundation

/// Defines the different types of questions that a form can contain.
enum QuestionType: String, CaseIterable, Identifiable, Codable {
    case multipleChoice = "Multiple Choice"
    case oddOneOut = "Odd One Out"
    case numeric = "Numeric Input"
    var id: String { rawValue }
}

/// Represents a single question within the form.
struct Question: Identifiable, Hashable, Codable {
    var id = UUID()
    var text: String = "New Question"
    var type: QuestionType = .multipleChoice
    var options: [Option] = [Option(text: "Option 1")]
    var images: [Data]? = nil // 🆕 For Odd One Out image storage
    
    // For odd one out: restrict number of images
        var canAddMoreImages: Bool {
            return options.count < 4
        }

        var hasMinimumImages: Bool {
            return options.count >= 2
        }
}

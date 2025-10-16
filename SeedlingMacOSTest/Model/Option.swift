import Foundation

/// Represents a single selectable option within a multiple-choice question.
struct Option: Identifiable, Hashable, Codable {
    var id = UUID()
    var text: String = ""
}

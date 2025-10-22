import Foundation

/// Represents a single selectable option within a multiple-choice question.
struct Option: Identifiable, Hashable, Codable {
    var id = UUID()
    var text: String = ""
    var imageData: Data? = nil  // NEW: stores uploaded image for "Odd One Out"
}

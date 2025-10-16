import Foundation

/// Represents the entire form that the user is creating.
/// Contains a title, description, and a list of questions.
struct Form: Identifiable, Codable {
    var id = UUID()
    var title: String = "Untitled Form"
    var description: String = ""
    var questions: [Question] = []
}

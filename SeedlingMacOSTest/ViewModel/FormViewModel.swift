//
//  FormViewModel.swift
//  SeedlingMacOSTest
//
//  Created by Vincenzo Gerelli on 16/10/25.
//


import SwiftUI

/// The ViewModel acts as the bridge between the model (Form)
/// and the SwiftUI views. It handles all business logic, such as
/// adding/removing questions, exporting the form, etc.
@Observable class FormViewModel {

    // The form being edited
    var form = Form(questions: [Question()])

    // Controls which view mode is currently active (Edit or Preview)
    var selectedView: ViewMode = .edit

    enum ViewMode {
        case edit, preview
    }

    // MARK: - Actions

    /// Adds a new question to the form based on its type
    func addQuestion(ofType type: QuestionType) {
        let newQuestion: Question
        switch type {
        case .multipleChoice:
            newQuestion = Question(type: .multipleChoice)
        case .oddOneOut:
            newQuestion = Question(text: "New Question", type: .oddOneOut, options: [])
        case .numeric:
            newQuestion = Question(text: "New Question", type: .numeric, options: [])
        }
        form.questions.append(newQuestion)
    }

    /// Removes a given question from the form
    func deleteQuestion(_ question: Question) {
        form.questions.removeAll { $0.id == question.id }
    }

    /// Moves questions up or down within the list
    func moveQuestions(from source: IndexSet, to destination: Int) {
        form.questions.move(fromOffsets: source, toOffset: destination)
    }

    
}

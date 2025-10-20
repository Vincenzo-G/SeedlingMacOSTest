//
//  QuestionEditView.swift
//  SeedlingMacOSTest
//
//  Created by Vincenzo Gerelli on 16/10/25.
//


import SwiftUI

/// Allows the user to edit a single question.
/// Supports changing question type, editing text, and adding/removing options.
struct QuestionEditView: View {
    @Binding var question: Question
    var deleteAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Top row: question text, type selector, and delete button
            HStack {
                TextField("Question text", text: $question.text)
                    .textFieldStyle(.roundedBorder)
                
                Picker("", selection: $question.type) {
                    ForEach(QuestionType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .labelsHidden()
                
                Button(action: deleteAction) {
                    Image(systemName: "trash").foregroundColor(.red)
                }
                .buttonStyle(.borderless)
            }

            // Options editor (only shown for multiple-choice questions)
            if question.type == .multipleChoice {
                ForEach($question.options) { $option in
                    HStack {
                        Image(systemName: "circle")
                        TextField("Option text", text: $option.text)
                        Button {
                            question.options.removeAll { $0.id == option.id }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                        }
                        .foregroundColor(.gray)
                        .buttonStyle(.borderless)
                    }
                }

                // Button to add new options
                Button("Add Option") {
                    question.options.append(Option(text: "New Option"))
                }
                .padding(.leading, 20)
            }
        }
    }
}

#Preview {
    QuestionEditView(question: .constant(FormViewModel().form.questions.first!), deleteAction: {})
}

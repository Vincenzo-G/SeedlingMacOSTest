//
//  QuestionPreviewView.swift
//  SeedlingMacOSTest
//
//  Created by Vincenzo Gerelli on 16/10/25.
//


import SwiftUI

/// Displays an individual question in preview mode.
/// Allows local interactivity (like selecting options or typing answers),
/// but does not persist responses yet.
struct QuestionPreviewView: View {
    let question: Question
    @State private var selectedOption: UUID?
    @State private var shortAnswerText: String = ""
    @State private var paragraphText: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(question.text).font(.headline)

            switch question.type {
            case .multipleChoice:
                // Simple radio-button style selection
                ForEach(question.options) { option in
                    Button(action: { selectedOption = option.id }) {
                        HStack {
                            Image(systemName: selectedOption == option.id ? "largecircle.fill.circle" : "circle")
                            Text(option.text)
                            Spacer()
                        }
                    }
                    .buttonStyle(.plain)
                }

            case .shortAnswer:
                // Single-line answer field
                TextField("Your answer", text: $shortAnswerText)
                    .textFieldStyle(.roundedBorder)

            case .paragraph:
                // Multi-line text area for long answers
                TextEditor(text: $paragraphText)
                    .border(Color.gray.opacity(0.5), width: 1)
                    .frame(height: 100)
            }
        }
        .padding()
        .background(Color(NSColor.windowBackgroundColor))
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

#Preview {
    QuestionPreviewView(question: FormViewModel().form.questions.first!)
}

import SwiftUI

/// Displays a read-only version of the form,
/// allowing users to preview how the final form will look.
struct PreviewView: View {
    let form: Form

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(form.title)
                    .font(.largeTitle).bold()
                
                if !form.description.isEmpty {
                    Text(form.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }

                Divider()

                // Render all questions in read-only mode
                ForEach(form.questions) { question in
                    QuestionPreviewView(question: question)
                }

                // Submit button (non-functional placeholder)
                HStack {
                    Spacer()
                    Button("Submit") { print("Form submitted!") }
                        .padding()
                }
            }
            .padding(30)
        }
    }
}

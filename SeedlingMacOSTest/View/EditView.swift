import SwiftUI

/// Displays the form editing interface.
/// Users can modify the form’s title, description, and questions.
struct EditView: View {
    @Bindable var viewModel: FormViewModel

    var body: some View {
        List {
            // Section for form title and description
            Section(header: Text("Form Details")) {
                TextField("Form Title", text: $viewModel.form.title)
                    .font(.title2)
                TextField("Form Description", text: $viewModel.form.description)
            }

            // Section for managing questions
            Section(header: Text("Questions")) {
                ForEach($viewModel.form.questions) { $question in
                    QuestionEditView(question: $question) {
                        viewModel.deleteQuestion(question)
                    }
                    .padding()
                    .background(Color(NSColor.controlBackgroundColor))
                    .cornerRadius(8)
                }
                .onMove(perform: viewModel.moveQuestions)
            }
        }
        .listStyle(.sidebar)
    }
}

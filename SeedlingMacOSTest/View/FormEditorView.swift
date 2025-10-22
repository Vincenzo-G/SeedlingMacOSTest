import SwiftUI

/// The main editor for a single form.
/// Displays a segmented picker to switch between Edit and Preview modes.
struct FormEditorView: View {
    @State private var viewModel = FormViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                // Toggle between Edit and Preview mode
                Picker("View Mode", selection: $viewModel.selectedView) {
                    Text("Edit").tag(FormViewModel.ViewMode.edit)
                    Text("Preview").tag(FormViewModel.ViewMode.preview)
                }
                .pickerStyle(.segmented)
                .padding()

                // Conditionally display EditView or PreviewView
                if viewModel.selectedView == .edit {
                    EditView(viewModel: viewModel)
                } else {
                    PreviewView(form: viewModel.form)
                }
            }
            .navigationTitle("Form Builder")
            .toolbar {
                ToolbarItemGroup {
                    // Menu for adding new questions
                    Menu {
                        Button("Add Multiple Choice") {
                            viewModel.addQuestion(ofType: .multipleChoice)
                        }
                        Button("Add Odd one out") {
                            viewModel.addQuestion(ofType: .oddOneOut)
                        }
                        Button("Add Numeric") {
                            viewModel.addQuestion(ofType: .numeric)
                        }
                    } label: {
                        Label("Add Question", systemImage: "plus")
                    }
                }
            }
        }
        .frame(minWidth: 600, minHeight: 400)
    }
}

#Preview {
    FormEditorView()
}

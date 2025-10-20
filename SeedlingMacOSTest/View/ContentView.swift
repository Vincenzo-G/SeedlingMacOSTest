//
//  ContentView.swift
//  SeedlingMacOSTest
//
//  Created by Vincenzo Gerelli on 16/10/25.
//


import SwiftUI

/// The main view of the app.
/// Displays the toolbar, view selector, and either the editing or preview mode.
struct ContentView: View {
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
                        Button("Add Short Answer") {
                            viewModel.addQuestion(ofType: .shortAnswer)
                        }
                        Button("Add Paragraph") {
                            viewModel.addQuestion(ofType: .paragraph)
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
    ContentView()
}

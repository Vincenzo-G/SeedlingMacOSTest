import SwiftUI

struct HomeView: View {
    @State private var forms: [Form] = []
    @State private var selectedForm: Form?

    private let gridColumns = [GridItem(.adaptive(minimum: 180), spacing: 20)]

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Your Forms")
                        .font(.largeTitle)
                        .bold()
                    Spacer()

                    Button(action: addNewForm) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Form")
                        }
                        .font(.headline)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal)
                .padding(.top)

                ScrollView {
                    LazyVGrid(columns: gridColumns, spacing: 20) {
                        ForEach(forms) { form in
                            Button(action: { selectedForm = form }) {
                                VStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.blue.opacity(0.2))
                                        .frame(height: 120)
                                        .overlay(
                                            Text("Preview")
                                                .foregroundColor(.blue)
                                                .font(.subheadline)
                                        )

                                    Text(form.title)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        .padding(.top, 5)
                                }
                                .padding()
                                .background(Color(NSColor.windowBackgroundColor))
                                .cornerRadius(10)
                                .shadow(radius: 2)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
            .navigationDestination(isPresented: Binding(
                get: { selectedForm != nil },
                set: { if !$0 { selectedForm = nil } }
            )) {
                // Navigate to FormEditorView
                FormEditorView()
            }
        }
    }

    private func addNewForm() {
        let newForm = Form(title: "New Form \(forms.count + 1)")
        forms.append(newForm)
    }
}

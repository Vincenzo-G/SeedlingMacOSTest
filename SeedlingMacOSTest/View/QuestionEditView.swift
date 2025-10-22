import SwiftUI
import UniformTypeIdentifiers
import AppKit

struct QuestionEditView: View {
    @Binding var question: Question
    var deleteAction: () -> Void
    
    // ✅ Larger grid spacing & adaptive sizing for better layout
    private let gridColumns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // MARK: - Question Text & Picker
            HStack {
                TextField("Question text", text: $question.text)
                    .textFieldStyle(.roundedBorder)
                    .frame(minWidth: 300)
                
                Picker("", selection: $question.type) {
                    ForEach(QuestionType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .labelsHidden()
                .frame(width: 180)
                
                Button(action: deleteAction) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
                .buttonStyle(.borderless)
            }
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
            // MARK: - Odd One Out Section
            if question.type == .oddOneOut {
                Text("Add images:")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                ScrollView {
                    LazyVGrid(columns: gridColumns, spacing: 20) { // ✅ More spacing
                        ForEach(question.images ?? [], id: \.self) { imageData in
                            if let nsImage = NSImage(data: imageData) {
                                ZStack(alignment: .topTrailing) {
                                    Image(nsImage: nsImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 160, height: 160) // ✅ Bigger image
                                        .clipped()
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.gray.opacity(0.3))
                                        )
                                        .shadow(radius: 4)
                                        .animation(.easeInOut, value: question.images)
                                    
                                    Button {
                                        removeImage(imageData)
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.red)
                                            .background(Color.white.opacity(0.8))
                                            .clipShape(Circle())
                                    }
                                    .buttonStyle(.borderless)
                                    .offset(x: 6, y: -6)
                                }
                            } else {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray)
                                    .frame(width: 160, height: 160)
                                    .overlay(Text("Invalid image"))
                            }
                        }
                        
                        // MARK: - Add Image Button
                        Button(action: openImagePicker) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.5), style: StrokeStyle(lineWidth: 2, dash: [6]))
                                    .frame(width: 160, height: 160)
                                
                                VStack(spacing: 8) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.accentColor)
                                        .font(.system(size: 36))
                                    Text("Add Image")
                                        .foregroundColor(.accentColor)
                                        .font(.subheadline)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.vertical, 10)
                }
                .frame(minHeight: 200)
            }
        }
        .padding(.vertical, 12)
    }
    
    // MARK: - Image Handling
    private func openImagePicker() {
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [.image]
        panel.allowsMultipleSelection = true
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        panel.begin { response in
            guard response == .OK else { return }
            
            // Small delay to allow proper UI update after picker closes
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                var newImages = question.images ?? []
                
                for url in panel.urls {
                    if let data = try? Data(contentsOf: url) {
                        newImages.append(data)
                    }
                }
                
                withAnimation(.easeInOut) {
                    question.images = newImages
                }
            }
        }
    }
    
    private func removeImage(_ data: Data) {
        var newImages = question.images ?? []
        newImages.removeAll { $0 == data }
        withAnimation(.easeInOut) {
            question.images = newImages
        }
    }
}

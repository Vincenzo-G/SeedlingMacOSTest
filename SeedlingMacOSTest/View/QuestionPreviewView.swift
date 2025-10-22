import SwiftUI
import AppKit

struct QuestionPreviewView: View {
    let question: Question
    @State private var selectedOption: UUID?
    @State private var numericAnswer: String = ""
    
    // ✅ Larger cells and more spacing
    private let gridColumns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // MARK: - Question Text
            Text(question.text)
                .font(.title3)
                .bold()
                .padding(.bottom, 4)
            
            // MARK: - Type-Based Display
            switch question.type {
            case .multipleChoice:
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(question.options) { option in
                        Button(action: { selectedOption = option.id }) {
                            HStack {
                                Image(systemName: selectedOption == option.id ? "largecircle.fill.circle" : "circle")
                                Text(option.text)
                                    .font(.body)
                                Spacer()
                            }
                            .padding(.vertical, 4)
                        }
                        .buttonStyle(.plain)
                    }
                }
                
            case .oddOneOut:
                if let images = question.images, !images.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: gridColumns, spacing: 20) { // ✅ More space between items
                            ForEach(images, id: \.self) { data in
                                if let nsImage = NSImage(data: data) {
                                    Image(nsImage: nsImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 160, height: 160) // ✅ Bigger images
                                        .clipped()
                                        .cornerRadius(10)
                                        .shadow(radius: 4)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.gray.opacity(0.3))
                                        )
                                }
                            }
                        }
                        .padding(.vertical, 10)
                    }
                    .frame(minHeight: 200)
                } else {
                    Text("No images added yet")
                        .foregroundColor(.secondary)
                        .padding(.top, 8)
                }
                
            case .numeric:
                TextField("Enter number", text: $numericAnswer)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 150)
            }
        }
        .padding()
        .background(Color(NSColor.windowBackgroundColor))
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

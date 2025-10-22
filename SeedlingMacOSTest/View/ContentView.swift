import SwiftUI

/// The main entry point of the app.
/// Displays the HomeView, which shows the list of forms and allows adding new ones.
struct ContentView: View {
    var body: some View {
        HomeView()
            .frame(minWidth: 800, minHeight: 600)
    }
}

#Preview {
    ContentView()
}

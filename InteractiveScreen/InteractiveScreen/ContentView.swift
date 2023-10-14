import SwiftUI

struct InteractiveScreen: View {
    @State private var isToggled = false
    @State private var sliderValue = 0.5
    @State private var stepperValue = 0
    @State private var text = ""
    @State private var isShowingAlert = false
    @State private var isShowingActionSheet = false
    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero

    struct Item: Identifiable {
        let id = UUID()
        let name: String
    }

    @State private var items: [Item] = []

    var body: some View {
        NavigationView {
            VStack {
                Button("Tap Me") {
                    // Handle button tap action
                    isToggled.toggle()
                }
                .padding()

                Toggle("Enable Feature", isOn: $isToggled)
                    .padding()

                Slider(value: $sliderValue, in: 0...1)
                    .padding()

                Stepper("Value: \(stepperValue)", value: $stepperValue)
                    .padding()

                TextField("Enter Text", text: $text)
                    .padding()

                NavigationLink(destination: Text("Next View")) {
                    Text("Go to Next View")
                }
                .padding()

                Circle()
                    .gesture(
                        DragGesture()
                            .updating($dragOffset) { value, state, _ in
                                state = value.translation
                            }
                            .onEnded { value in
                                position.width += value.translation.width
                                position.height += value.translation.height
                            }
                    )
                    .offset(position)
                    .frame(width: 100, height: 100)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .padding()

                List(items) { item in
                    Text(item.name)
                }
                .padding()

                Button("Show Alert") {
                    isShowingAlert = true
                }
                .padding()
                .alert(isPresented: $isShowingAlert) {
                    Alert(title: Text("Alert Title"), message: Text("This is an alert message"), dismissButton: .default(Text("OK")))
                }

                Button("Show Action Sheet") {
                    isShowingActionSheet = true
                }
                .padding()
                .actionSheet(isPresented: $isShowingActionSheet) {
                    ActionSheet(title: Text("Actions"), buttons: [
                        .default(Text("Option 1")),
                        .default(Text("Option 2")),
                        .destructive(Text("Delete"), action: {
                            // Handle delete action
                        }),
                        .cancel()
                    ])
                }
            }
            .padding()
            .navigationTitle("Interactive Features")
        }
    }
}

struct InteractiveScreen_Previews: PreviewProvider {
    static var previews: some View {
        InteractiveScreen()
    }
}

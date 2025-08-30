import SwiftUI

struct TransformControlPanelView: View {
    
    private enum Layout {
        static let controlPanelHeight: CGFloat = 300
        static let spacing: CGFloat = 8
        static let innerSpacing: CGFloat = 4
    }
    
    private enum Field: Hashable {
        case positionX, positionY, rotationDegrees, pivotX, pivotY
    }
    
    @Binding var state: TransformState
    @State private var positionX = "0"
    @State private var positionY = "0"
    @State private var rotationDegrees = "0"
    @State private var pivotX = "0"
    @State private var pivotY = "0"
    @FocusState private var focusedField: Field?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            CornerInfoView(state: state)
            Spacer().frame(height: Layout.spacing)
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white.opacity(0.5))
                    .stroke(Color.black, style: StrokeStyle(lineWidth: 1))
                    
                VStack(alignment: .leading, spacing: Layout.spacing) {
                    VStack(alignment: .leading, spacing: Layout.innerSpacing) {
                        Text("좌 표")
                        HStack(spacing: Layout.innerSpacing) {
                            Text("X: ")
                            makeNumericField($positionX, "X", .positionX)
                            Text("Y: ")
                            makeNumericField($positionY, "Y", .positionY)
                        }
                    }
                    VStack(alignment: .leading, spacing: Layout.innerSpacing) {
                        Text("회 전")
                        makeNumericField($rotationDegrees, "deg", .rotationDegrees)
                    }
                    VStack(alignment: .leading, spacing: Layout.innerSpacing) {
                        Text("원 점")
                        HStack(spacing: Layout.innerSpacing) {
                            Text("X: ")
                            makeNumericField($pivotX, "X", .pivotX)
                            Text("Y: ")
                            makeNumericField($pivotY, "Y", .pivotY)
                        }
                    }
                    HStack(spacing: Layout.spacing) {
                        Spacer()
                        Button("적 용") {
                            applyInputs()
                        }
                        .buttonStyle(.borderedProminent)
                        Button("초기화") {
                            resetInputs()
                        }
                        .buttonStyle(.bordered)
                        Spacer()
                    }
                }
                .padding()
            }
            .frame(height: Layout.controlPanelHeight)
        }
        .onAppear {
            syncInputsFromState()
        }
    }
    
    private func makeNumericField(_ binding: Binding<String>, _ placeholder: String, _ field: Field) -> some View {
        HStack(spacing: 4) {
            TextField(placeholder, text: binding)
                .keyboardType(.numbersAndPunctuation)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.done)
                .onSubmit { applyInputs() }
                .focused($focusedField, equals: field)
            
            Button(action: {
                binding.wrappedValue = ""
                focusedField = field
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .buttonStyle(.plain)
            .opacity(binding.wrappedValue.isEmpty ? 0.3 : 1.0)
        }
    }
    
    private func applyInputs() {
        var nextState = state
        nextState.position.x = parseNumber(positionX, fallback: state.position.x)
        nextState.position.y = parseNumber(positionY, fallback: state.position.y)
        nextState.rotationDegrees = parseNumber(rotationDegrees, fallback: state.rotationDegrees)
        nextState.pivot.x = parseNumber(pivotX, fallback: state.pivot.x)
        nextState.pivot.y = parseNumber(pivotY, fallback: state.pivot.y)
        state = nextState
        syncInputsFromState()
    }
    
    private func resetInputs() {
        state = TransformState()
        syncInputsFromState()
    }
    
    private func parseNumber(_ text: String, fallback: CGFloat) -> CGFloat {
        guard let value = Double(text) else { return fallback }
        return CGFloat((value * 100).rounded() / 100)
    }
    
    private func formatCoordinate(_ value: CGFloat) -> String {
        String(format: "%.2f", value)
    }
    
    private func syncInputsFromState() {
        positionX = formatCoordinate(state.position.x)
        positionY = formatCoordinate(state.position.y)
        rotationDegrees = formatCoordinate(state.rotationDegrees)
        pivotX = formatCoordinate(state.pivot.x)
        pivotY = formatCoordinate(state.pivot.y)
    }
}

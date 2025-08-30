import SwiftUI

struct TransformCanvas: UIViewRepresentable {
    
    var state: TransformState
    
    func makeUIView(context: Context) -> TransformCanvasView {
        TransformCanvasView()
    }
    
    func updateUIView(_ uiView: TransformCanvasView, context: Context) {
        uiView.update(state: state)
    }
}

import UIKit

final class TransformCanvasView: UIView {
    
    private var state = TransformState()
    
    func update(state newState: TransformState) { 
        state = newState
        setNeedsDisplay() 
    }
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        ctx.translateBy(x: 0, y: bounds.height)
        ctx.scaleBy(x: 1, y: -1)
        
        let transform = TransformGeometry.makeTransform(for: state)
        ctx.saveGState()
        ctx.concatenate(transform)
        let box = CGRect(origin: .zero, size: state.size)
        ctx.setFillColor(UIColor.systemGray3.cgColor)
        ctx.fill(box)
        ctx.setStrokeColor(UIColor.black.cgColor)
        ctx.setLineWidth(1)
        ctx.stroke(box)
        ctx.restoreGState()
        
        let pivotDotRadius: CGFloat = 10
        let position = state.position
        let dot = CGRect(
            x: position.x - pivotDotRadius,
            y: position.y - pivotDotRadius,
            width: pivotDotRadius * 2,
            height: pivotDotRadius * 2
        )
        ctx.setFillColor(UIColor.systemRed.cgColor)
        ctx.fillEllipse(in: dot)
    }
}


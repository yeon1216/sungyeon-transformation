import CoreGraphics

enum Corner: String, CaseIterable {
    case leftTop, rightTop, rightBottom, leftBottom
}

struct TransformGeometry {
    static func makeTransform(for state: TransformState) -> CGAffineTransform {
        CGAffineTransform(translationX: state.position.x, y: state.position.y)
            .rotated(by: state.rotationDegrees * .pi / 180)
            .translatedBy(x: -state.pivot.x, y: -state.pivot.y)
    }
    
    static func localCorners(size: CGSize) -> [Corner: CGPoint] {
        [
            .leftTop: .init(x: 0, y: size.height),
            .rightTop: .init(x: size.width, y: size.height),
            .rightBottom: .init(x: size.width, y: 0),
            .leftBottom: .zero
        ]
    }
    
    static func globalCorners(for state: TransformState) -> [Corner: CGPoint] {
        let transform = makeTransform(for: state)
        return localCorners(size: state.size).mapValues { $0.applying(transform) }
    }
}

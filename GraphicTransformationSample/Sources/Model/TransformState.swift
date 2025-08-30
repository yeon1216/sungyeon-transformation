import CoreGraphics

struct TransformState: Equatable {
    var position: CGPoint = .zero
    var pivot: CGPoint = .zero
    var rotationDegrees: CGFloat = 0
    let size: CGSize = .init(width: 100, height: 100)
}


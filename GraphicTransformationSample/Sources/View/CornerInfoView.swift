import SwiftUI

struct CornerInfoView: View {
    
    private enum Layout {
        static let cornerInfoHeight: CGFloat = 100
    }
    
    let state: TransformState
    
    var body: some View {
        let globalCorners = TransformGeometry.globalCorners(for: state)
        HStack {
            Spacer(minLength: 0)
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray.opacity(0.5))
                    .stroke(Color.black, style: StrokeStyle(lineWidth: 1))
                    
                VStack(alignment: .leading, spacing: 2) {
                    Text("Left-Top: \(format(point: globalCorners[.leftTop]))")
                    Text("Right-Top: \(format(point: globalCorners[.rightTop]))")
                    Text("Right-Bottom: \(format(point: globalCorners[.rightBottom]))")
                    Text("Left-Bottom: \(format(point: globalCorners[.leftBottom]))")
                }
                .font(.system(.body, design: .monospaced))
            }
            .frame(height: Layout.cornerInfoHeight)
            Spacer(minLength: 0)
        }
    }
    
    private func format(point: CGPoint?) -> String {
        guard let point else { return "—" }
        return String(format:"(%.2f, %.2f)", point.x, point.y)
    }
}

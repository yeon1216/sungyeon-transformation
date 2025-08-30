import SwiftUI

@main
struct TransformationApp: App {
    
    @State var state = TransformState()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                VStack {
                    TransformCanvas(state: state).frame(height: 320).border(.gray)
                    Spacer()
                }
                VStack {
                    Spacer()
                    TransformControlPanelView(state: $state).padding()
                }
            }
            
        }
    }
}

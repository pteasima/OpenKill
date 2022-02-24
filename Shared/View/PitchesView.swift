import SwiftUI
import Service

struct PitchesView: View {
  @Environment(\.[key: \UUID.self]) private var generateUUID
  var body: some View {
    List {
      Text("List of Pitches")
    }
    .toolbar {
      NavigationLink {
        CreatePitchView(draft: .init(id: .init(rawValue: generateUUID().uuidString), description: ""))
      } label: {
        Text("+")
      }
    }
  }
}

struct PitchesView_Previews: PreviewProvider {
  static var previews: some View {
    PitchesView()
  }
}

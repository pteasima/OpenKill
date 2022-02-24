import SwiftUI


struct CreatePitchView: View {
  @Environment(\.presentationMode) private var presentationMode
  @Environment(\.[key: \DAPI.self]) private var dapi
  @Environment(\.[key: \Throw.self]) private var `throw`
  @State var draft: Pitch
  @State private var showsPublishConfirmation: Bool = false
  var body: some View {
    //TODO: placeholder when empty
    TextEditor(text: $draft.description)
      .navigationTitle("New Pitch")
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarLeading) {
          Button {
            presentationMode.wrappedValue.dismiss()
          } label: {
            Text("Cancel")
          }
        }
        //TODO: make button more promitent
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          Button {
            showsPublishConfirmation = true
          } label: {
            Text("Publish")
          }
        }
      }
      .confirmationDialog("Really publish this Pitch on the Ethereum network? TODO: btw you'll have to pay gas for this", isPresented: $showsPublishConfirmation) {
        Button {
          `throw`.try {
            try await dapi.createPitch(draft)
            presentationMode.wrappedValue.dismiss()
          }
          
        } label: {
          Text("Publish on Ethereum network (TODO: + gas price")
        }
      }
  }
}

struct CreatePitchView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      CreatePitchView(draft: .samples.0)
    }
  }
}

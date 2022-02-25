import Firebase
import Foundation
import SwiftUI

let db = Firestore.firestore()
struct RootView: View {
    var body: some View {
        Button("Do something!") {
            addAlanTuring()
            getCollection()
        }
    }

    private func addAlanTuring() {
        var ref: DocumentReference?
        ref = db.collection("users").addDocument(data: [
            "first": "Alan",
            "middle": "Mathison",
            "last": "Turing",
            "born": 1912
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }

    private func getCollection() {
        db.collection("users").getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

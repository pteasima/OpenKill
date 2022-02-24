import Foundation
import Tagged

struct Pitch: Codable {
  typealias ID = Tagged<Self, String>
  let id: ID
  var description: String
}

extension Pitch {
  static var samples = (
    Self(
      id: "sample pitch0",
      description: "provide proof of death of a russian soldier on ukranian soil"
    ),
    Self(
      id: "sample pitch1",
      description: "provide proof of a russian helicopter being shot down on ukranian soil"
    )
  )
}

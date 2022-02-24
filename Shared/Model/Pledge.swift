import Foundation
import Tagged

struct Pledge: Codable {
  typealias ID = Tagged<Self, String>
  let id: ID
  var expiry: Date = .distantFuture
  var amount: ETH
  var comment: String = "Go get em!"
}

extension Pledge {
  static var samples = (
    Self(
      id: "sample pledge0",
      amount: 42
    ),
    Self(
      id: "sample pledge1",
      amount: 420
    )
  )
}

import Foundation
import Tagged

struct Kill {
  typealias ID = Tagged<Self, String>
  let id: ID
  var proof: URL //TODO: do some crypto shit to prove the content was signed by private key of beneficiary
  typealias Beneficiary = Tagged<Self, ETH.Address>
  var beneficiary: Beneficiary
}

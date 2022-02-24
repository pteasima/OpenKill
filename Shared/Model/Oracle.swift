import Foundation
import Tagged

struct Oracle: Identifiable {
  typealias ID = Tagged<Self, ETH.Address>
  let id: ID // public key
  
}

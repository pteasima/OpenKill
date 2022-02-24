import Foundation
import SwiftUI

// decentralized api, i.e. calls to the ethereum smart contracts
struct DAPI: EnvironmentKey {
  static var defaultValue: Self = .init()
  
  var createPitch: (Pitch) async throws -> Void = { pitch in
    print("created pitch")
  }
}

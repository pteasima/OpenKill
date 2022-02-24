import Foundation
import SwiftUI

extension UUID: EnvironmentKey {
  public static var defaultValue: () -> UUID = UUID.init
}

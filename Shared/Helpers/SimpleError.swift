import Foundation

public struct SimpleError: LocalizedError {
  public var errorDescription: String?
}

public extension SimpleError {
  init(_ errorDescription: String?) {
    self.init(errorDescription: errorDescription)
  }
}

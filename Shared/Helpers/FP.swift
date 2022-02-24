public func absurd<A>(_ never: Never) -> A {}

@inlinable
public func with<T>(_ value: T, _ block: (inout T) throws -> Void) rethrows -> T {
  var copy = value
  try block(&copy)
  return copy
}

public struct Blank: Hashable, Codable {}

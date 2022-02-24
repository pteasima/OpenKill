@dynamicMemberLookup public protocol Lookup {
  associatedtype LookupValue
  associatedtype Path: KeyPath<Self, LookupValue> = WritableKeyPath<Self, LookupValue>
  var lookup: WritableKeyPath<Self, LookupValue> { get } // I think I had a reason not to make this static, but now Im not sure
}
public extension Lookup {
  subscript<Subject>(dynamicMember keyPath: WritableKeyPath<LookupValue, Subject>) -> Subject {
    get { self[keyPath: lookup.appending(path: keyPath)] }
    set { self[keyPath: lookup.appending(path: keyPath)] = newValue }
  }
  subscript<Subject>(dynamicMember keyPath: KeyPath<LookupValue, Subject>) -> Subject {
    self[keyPath: lookup.appending(path: keyPath)]
  }
}

public extension Lookup {
  subscript<L,R, Subject>(dynamicMember keyPath: WritableKeyPath<L, Subject>) -> Subject
  where LookupValue == (L, R) {
    get { self[keyPath: lookup.appending(path: \.0).appending(path: keyPath)] }
    set { self[keyPath: lookup.appending(path: \.0).appending(path: keyPath)] = newValue }
  }
  subscript<L,R, Subject>(dynamicMember keyPath: KeyPath<L, Subject>) -> Subject
  where LookupValue == (L, R) {
    self[keyPath: lookup.appending(path: \.0).appending(path: keyPath)]
  }
  
  subscript<L,R, Subject>(dynamicMember keyPath: WritableKeyPath<R, Subject>) -> Subject
  where LookupValue == (L, R) {
    get { self[keyPath: lookup.appending(path: \.1).appending(path: keyPath)] }
    set { self[keyPath: lookup.appending(path: \.1).appending(path: keyPath)] = newValue }
  }
  subscript<L,R, Subject>(dynamicMember keyPath: KeyPath<R, Subject>) -> Subject
  where LookupValue == (L, R) {
    self[keyPath: lookup.appending(path: \.1).appending(path: keyPath)]
  }
}

public extension Lookup {
  subscript<L, R>(left left: WritableKeyPath<Self, L>, right right: WritableKeyPath<Self, R>) -> LookupValue
  where LookupValue == (L,R) {
    get { (self[keyPath: left], self[keyPath: right]) }
    set {
      self[keyPath: left] = newValue.0
      self[keyPath: right] = newValue.1
    }
  }
}

import Foundation
import SwiftUI
import Combine
import Service

public struct Throw: EnvironmentKey {
  public static var defaultValue: Self = .init()
  
  @MainActor public  var handleError: (Error) -> Void = { error in
    print("Unhandled user-facing error: \(error.localizedDescription) , \(error)")
    #if DEBUG
    raise(SIGINT) // trigger a breakpoint
    #endif
  }
  public func callAsFunction(_ error: Error) {
    Task {
      await handleError(error)
    }
  }
  
  public func `try`(_ work: (() throws -> Void)) {
    do {
      try work()
    } catch {
      self(error)
    }
  }
  
  public func `try`(_ work: @escaping () async throws -> Void) async {
    do {
      try await work()
    } catch {
      self(error)
    }
  }
  
  @discardableResult
  public func `try`(_ work: @escaping () async throws -> Void) -> Task<(), Never> {
    Task {
      await `try`(work)
    }
  }
}

public extension Throw {
  init(boundTo error: Binding<Error?>) {
    self.init {
      error.wrappedValue = $0
    }
  }
}

extension Publisher {
  func sendErrors(to throw: Throw, completeOnError: Bool = true) -> Publishers.Catch<Publishers.HandleEvents<Self>, Empty<Self.Output, Never>> {
    handleErrors(using: `throw`)
      .`catch` { _ in Empty<Self.Output, Never>(completeImmediately: completeOnError) }
  }
  func handleErrors(using throw: Throw) -> Publishers.HandleEvents<Self> {
    handleEvents(receiveCompletion: {
      if case .failure(let error) = $0 {
        `throw`(error)
      }
    })
  }
}

public struct ThrowingTask: ViewModifier {
  @Environment(\.[key: \Throw.self]) private var `throw`
  var action: () async throws -> Void
  public func body(content: Content) -> some View {
    content
      .task {
        `throw`.try(action)
      }
  }
}

public extension View {
  func throwingTask(_ action: @escaping () async throws -> Void) -> some View {
    modifier(ThrowingTask(action: action))
  }
}

fileprivate struct ShowErrors: ViewModifier {
  var shouldPrint: Bool
  @State private var errors: [Error] = []
  func body(content: Content) -> some View {
    content
      .alert(
        isPresented: Binding(
          get: { !errors.isEmpty },
          set: { if !$0 { errors.removeFirst() } }
        )
      ) {
        let error = errors.first ?? SimpleError("Undefined Error")
        return Alert(
          title: Text("Error"),
          message: Text(errorDescription(error)),
          primaryButton: .default(Text("Copy error")) {
            UIPasteboard.general.string = fullDescription(error)
          },
          secondaryButton: .default(Text("OK"))
        )
      }
      .environment(\.[key: \Throw.self], Throw { error in
        if shouldPrint {
          print("error: ", error, "description: ", error.localizedDescription)
        }
        errors.append(error)
      })
  }

  private func errorDescription(_ error: Error) -> String {
    #if DEBUG
    return fullDescription(error)
    #else
    return error.localizedDescription
    #endif
  }

  private func fullDescription(_ error: Error) -> String {
    return error.localizedDescription + ", \(error)"
  }
}

public extension View {
  func showErrors(shouldPrint: Bool = true) -> some View {
    modifier(ShowErrors(shouldPrint: shouldPrint))
  }
}


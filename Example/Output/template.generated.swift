// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

@testable import Example







// MARK: - Sourcery Helper

protocol _StringRawRepresentable: RawRepresentable {
  var rawValue: String { get }
}

final class _Invocation {
  let name: String
  let date = Date()
  private var parameters: [String: Any] = [:]

  init(name: String) {
    self.name = name
  }

  func set<T: _StringRawRepresentable>(parameter: Any, forKey key: T) {
    parameters[key.rawValue] = parameter
  }
  func parameter<T: _StringRawRepresentable>(for key: T) -> Any? {
    return parameters[key.rawValue]
  }
}

final class _Actions {
  enum Keys: String, _StringRawRepresentable {
    case closure
    case returnValue
    case defaultReturnValue
    case error
  }
  private var invocations: [_Invocation] = []

  // MARK: - closure

  func setClosure<T: _StringRawRepresentable>(_ value: () -> Void, for functionName: T) {
    let invocation = self.invocation(for: functionName)
    invocation.set(parameter: value, forKey: Keys.closure)
  }
  func closure<T: _StringRawRepresentable>(for functionName: T) -> (() -> Void)? {
    let invocation = self.invocation(for: functionName)
    return invocation.parameter(for: Keys.closure) as? (() -> Void)
  }

  // MARK: - returnValue

  func setReturnValue<T: _StringRawRepresentable>(_ value: Any, for functionName: T) {
    let invocation = self.invocation(for: functionName)
    invocation.set(parameter: value, forKey: Keys.returnValue)
  }
  func returnValue<T: _StringRawRepresentable>(for functionName: T) -> Any? {
    let invocation = self.invocation(for: functionName)
    return invocation.parameter(for: Keys.returnValue) ?? invocation.parameter(for: Keys.defaultReturnValue)
  }

  // MARK: - defaultReturnValue

  func setDefaultReturnValue<T: _StringRawRepresentable>(_ value: Any, for functionName: T) {
    let invocation = self.invocation(for: functionName)
    invocation.set(parameter: value, forKey: Keys.defaultReturnValue)
  }
  func defaultReturnValue<T: _StringRawRepresentable>(for functionName: T) -> Any? {
    let invocation = self.invocation(for: functionName)
    return invocation.parameter(for: Keys.defaultReturnValue) as? (() -> Void)
  }

  // MARK: - error

  func setError<T: _StringRawRepresentable>(_ value: Error, for functionName: T) {
    let invocation = self.invocation(for: functionName)
    invocation.set(parameter: value, forKey: Keys.error)
  }
  func error<T: _StringRawRepresentable>(for functionName: T) -> Error? {
    let invocation = self.invocation(for: functionName)
    return invocation.parameter(for: Keys.error) as? Error
  }

  // MARK: - private

  private func invocation<T: _StringRawRepresentable>(for name: T) -> _Invocation {
    if let invocation = invocations.filter({ $0.name == name.rawValue }).first {
      return invocation
    }
    let invocation = _Invocation(name: name.rawValue)
    invocations += [invocation]
    return invocation
  }
}

final class _Invocations {
  private var history = [_Invocation]()

  func record(_ invocation: _Invocation) {
    history += [invocation]
  }

  func isInvoked<T: _StringRawRepresentable>(_ name: T) -> Bool {
    return history.contains(where: { $0.name == name.rawValue })
  }

  func numOfTimesInvoked<T: _StringRawRepresentable>(_ name: T) -> Int {
    return history.filter {  $0.name == name.rawValue }.count
  }

  func allInvocations() -> [_Invocation] {
    return history.sorted { $0.date < $1.date }
  }

  func findInvocations<T: _StringRawRepresentable>(for name: T) -> [_Invocation] {
    return history.filter {  $0.name == name.rawValue }.sorted { $0.date < $1.date }
  }

  func findParameter<T: _StringRawRepresentable, U: _StringRawRepresentable>(_ key: T, inFunction name: U) -> Any? {
    return history.filter {  $0.name == name.rawValue }.first?.parameter(for: key)
  }
}

// MARK: - Sourcery Mocks

class MockMyObject: NSObject, Testing {
    var aVarible: Bool {
        get { return _aVarible }
        set(value) { _aVarible = value }
    }
    var _aVarible: Bool! = false
    let invocations = _Invocations()
    let actions = _Actions()

    enum funcs: String, _StringRawRepresentable {
      case foo1
    }

    //MARK: - foo

    func foo() -> Bool {
        let functionName = funcs.foo1
        let invocation = _Invocation(name: functionName.rawValue)
        invocations.record(invocation)
        actions.closure(for: functionName)?()
        actions.setDefaultReturnValue(false, for: functionName)
        return actions.returnValue(for: functionName) as! Bool
    }
}

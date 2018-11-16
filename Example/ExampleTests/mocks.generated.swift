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

struct _Variable<T> {
  let date = Date()
  var variable: T

  init(_ variable: T) {
    self.variable = variable
  }
}

final class _Invocation {
  let name: String
  let date = Date()
  private var parameters: [String: Any] = [:]

  init(name: String) {
    self.name = name
  }

  fileprivate func set<T: _StringRawRepresentable>(parameter: Any, forKey key: T) {
    parameters[key.rawValue] = parameter
  }
  func parameter<T: _StringRawRepresentable>(for key: T) -> Any? {
    return parameters[key.rawValue]
  }
}

final class _Actions {
  enum Keys: String, _StringRawRepresentable {
    case returnValue
    case defaultReturnValue
    case error
  }
  private var invocations: [_Invocation] = []

  // MARK: - returnValue

  func set<T: _StringRawRepresentable>(returnValue value: Any, for functionName: T) {
    let invocation = self.invocation(for: functionName)
    invocation.set(parameter: value, forKey: Keys.returnValue)
  }
  func returnValue<T: _StringRawRepresentable>(for functionName: T) -> Any? {
    let invocation = self.invocation(for: functionName)
    return invocation.parameter(for: Keys.returnValue) ?? invocation.parameter(for: Keys.defaultReturnValue)
  }

  // MARK: - defaultReturnValue

  fileprivate func set<T: _StringRawRepresentable>(defaultReturnValue value: Any, for functionName: T) {
    let invocation = self.invocation(for: functionName)
    invocation.set(parameter: value, forKey: Keys.defaultReturnValue)
  }
  fileprivate func defaultReturnValue<T: _StringRawRepresentable>(for functionName: T) -> Any? {
    let invocation = self.invocation(for: functionName)
    return invocation.parameter(for: Keys.defaultReturnValue) as? (() -> Void)
  }

  // MARK: - error

  func set<T: _StringRawRepresentable>(error: Error, for functionName: T) {
    let invocation = self.invocation(for: functionName)
    invocation.set(parameter: error, forKey: Keys.error)
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

  fileprivate func record(_ invocation: _Invocation) {
    history += [invocation]
  }

  func isInvoked<T: _StringRawRepresentable>(_ name: T) -> Bool {
    return history.contains(where: { $0.name == name.rawValue })
  }

  func count<T: _StringRawRepresentable>(_ name: T) -> Int {
    return history.filter {  $0.name == name.rawValue }.count
  }

  func all() -> [_Invocation] {
    return history.sorted { $0.date < $1.date }
  }

  func find<T: _StringRawRepresentable>(_ name: T) -> [_Invocation] {
    return history.filter {  $0.name == name.rawValue }.sorted { $0.date < $1.date }
  }
}

// MARK: - Sourcery Mocks

class MockMyObject: NSObject, MyObjectable {
    var aVarible: Bool {
        get { return _aVarible }
        set(value) { _aVarible = value; _aVaribleHistory.append(_Variable(value)) }
    }
    var _aVarible: Bool! = false
    var _aVaribleHistory: [_Variable<Bool>] = []
    let invocations = _Invocations()
    let actions = _Actions()

    // MARK: - foo

    func foo() -> Bool {
        let functionName = foo1.name
        let invocation = _Invocation(name: functionName.rawValue)
        invocations.record(invocation)
        actions.set(defaultReturnValue: false, for: functionName)
        return actions.returnValue(for: functionName) as! Bool
    }

    enum foo1: String, _StringRawRepresentable {
      case name = "foo1"
    }
}

# Swift Mockable

## Getting started

### 1. Installing Sourcery

Open your terminal and run:
`brew install sourcery`

### 2. Create project

Open XCode and create a new iOS or OSX project in Swift

### 3. Setup environment

In your terminal run:
```
cd path/to/swift/project
mkdir Output
mkdir Templates
cd ~/Desktop
git clone git@bitbucket.org:larromba/swift-mockable.git
cp swift-mockable/Templates/template.stencil path/to/swift/project/Templates
touch .sourcery.yml
open .sourcery.yml
```

In `.sourcery.yml` add:
```
sources:
  - ./path/to/sources
templates:
  - ./Templates
output:
  ./Output
```

In `template.stencil` update `<YOUR_APP_TARGET_NAME>` to be the name of your app target

### 4. Add Mockable protocol

In your Swift project, create a new file `Mockable.swift` and add:

```
import Foundation

protocol Mockable {} // Sourcery
```

### 5. Mock something

Create a protocol, and implement `Mockable`. For example:

```
// sourcery: name = Test, inherits = NSObject
protocol Testing: Mockable {
	// sourcery: value = false
	var aVarible: Bool { get }
	// sourcery: returnValue = false
	func foo() -> Bool
}
```

### 6. Add pre-build script

In your Swift project add this pre-build script phase before your `Compile Sources` phase:

```
/bin/sh
sourcery
```

### 7. Generate mocked classes

Run your project to generate a mocked class file found in:
`Output/template.generated.swift`

Add `template.generated.swift` to your tests target (don't copy). You only need to do this once. The file will update on each build

### 8. Write tests

You can now write your tests in your test target against your generated mocks

Each Mock class has the following items you can use whilst testing:

```
let mock = MockObject()
mock.invocations // monitors function invocations
mock.actions // stores function actions
mock.funcs // enum of all function names 
<functionName1>Parameters // enum of all parameters in functionName1`
<functionName2>Parameters // enum of all parameters in functionName2
//...etc

class Actions {
  // get / set closure for a function name
  func setClosure<T: StringRawRepresentable>(_ value: () -> Void, for functionName: T)
  func closure<T: StringRawRepresentable>(for functionName: T) -> (() -> Void)?
	
  // get / set return value for a function name
  func setReturnValue<T: StringRawRepresentable>(_ value: Any, for functionName: T)
  func returnValue<T: StringRawRepresentable>(for functionName: T) -> Any?
  
  // get / set throw error for a function name
  func setError<T: StringRawRepresentable>(_ value: Error, for functionName: T) {}
  func error<T: StringRawRepresentable>(for functionName: T) -> Error? {}
}

class Invocations {
  func isInvoked<T: StringRawRepresentable>(_ name: T) -> Bool
  func numOfTimesInvoked<T: StringRawRepresentable>(_ name: T)
  func allInvocations() -> [Invocation]
  func findInvocations<T: StringRawRepresentable>(for name: T) -> [Invocation]
  func findParameter<T: StringRawRepresentable, U: StringRawRepresentable>(_ key: T, inFunction name: U) -> Any? {}
}

class Invocation {
  let name: String
  let date = Date()
}
```

## Editing Code Generation

To edit the code generation, you can add annotations to your protocols inheriting from `Mockable` in the form of `// sourcery: ...` comments.

You can add annotations to:

#### protocol definitions
* **name**: the name to create a mock class from, e.g. `Object` would become `MockObject`
* **inherits**: the classes the mock should inherit from. if there are more than one, use quotes, e.g. `"NSObject, MyObject"`

#### protocol variables
* **value**: the default value to be initilised with, e.g. `NSTextField()`

#### protocol functions
* **returnValue**: the mock value to be returned, e.g. `true`

Note that all `NS` / `UI` objects will be automatically mocked with a default value, e.g. `var x = NSTextField()`. All variables whose type inherits from `Mockable` will also be mocked with a default value, e.g. `var x = MockObject()`.

## Known Issues

`init()` definitions in protocols aren't yet supported. This is a WIP.

## Credits

This script has been adapted from `AutoMockable.stencil` by [Sourcery](https://github.com/krzysztofzablocki/Sourcery)


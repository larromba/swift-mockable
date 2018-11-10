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
cd path/to/swift/project
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
// sourcery: name = MyObject, inherits = NSObject
protocol MyObjectable: Mockable {
  // sourcery: value = false
  var aVariable: Bool { get }

  // sourcery: returnValue = false
  func foo() -> Bool
}
```

### 6. Add pre-build script

In your Swift project test target add this pre-build script phase before your `Compile Sources` phase:

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
let mock = MockMyObject()
mock.invocations // monitors function invocations
mock.actions // stores function actions
mock.foo1.name // method foo's name
mock.foo1.params // enum of all parameters in foo()

class Actions {
  // get / set closure to run when a function is called
  func set<T: StringRawRepresentable>(closure: () -> Void, for functionName: T)
  func closure<T: StringRawRepresentable>(for functionName: T) -> (() -> Void)?
	
  // get / set return value for a function
  func set<T: StringRawRepresentable>(returnValue value: Any, for functionName: T)
  func returnValue<T: StringRawRepresentable>(for functionName: T) -> Any?
  
  // get / set error to be thrown (only for a throwable function)
  func set<T: StringRawRepresentable>(error: Error, for functionName: T) {}
  func error<T: StringRawRepresentable>(for functionName: T) -> Error? {}
}

class Invocations {
  // returns yes if function was invoked
  func isInvoked<T: StringRawRepresentable>(_ name: T) -> Bool

  // the number of times a function was invoked
  func count<T: StringRawRepresentable>(_ name: T) -> Int

  // all functions invoked
  func all() -> [Invocation]

  // all functions invoked of a given name
  func find<T: StringRawRepresentable>(_ name: T) -> [Invocation]

  // gets a parameter that was passed to a function. you must cast it to the expected type
  func find<T: StringRawRepresentable, U: StringRawRepresentable>(parameter: T, inFunction name: U) -> Any?
}

class Invocation {
  // name of the function
  let name: String

  // time function was called
  let date = Date()

  // returns a parameter that was passed to a function. you must cast it to the expected type
  func parameter<T: StringRawRepresentable>(for key: T) -> Any?
}

// Here's an example test

class ViewControllerTests: XCTestCase {
  func testFooCalledOnViewDidLoad() {
    // mocks
    let sut = MockMyObject()
    let viewController = ViewController()

    // setup
    viewController.myObject = sut

    // test
    viewController.viewDidLoad()
    XCTAssertTrue(sut.invocations.isInvoked(MockMyObject.foo1.name))
  }
}
```

## Modifying Code Generation

To edit the code generation, you can add annotations to protocols inheriting from `Mockable` in the form of `// sourcery: ...` comments.

#### protocol definitions

```
    // sourcery: name = Object
    // sourcery: inherits = "NSObject, MyObject"
    // sourcery: init = coder
    // sourcery: associatedtype = MyType
    protocol Objectable: Mockable {
        associatedtype MyType
    }
```

* **name**: normalized name to create a mock class from, e.g. `Object` would become `MockObject`
* **inherits**: classes the mock should inherit from. if there are more than one, use quotes, e.g. `"NSObject, MyObject"`
* **init**: add boiler plate init code to your mock object. 

	*init = coder*

```
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
```
* **associatedtype**: associatedtypes are [not yet supported](https://github.com/krzysztofzablocki/Sourcery/issues/539) by Sourcery out of the box, so you must mark them as an annotation, e,g. `associatedtype = MyType` would become:

```
    class MockObject: Objectable {
        typealias MyType = Any
    }
```

#### protocol variables

```
    protocol Objectable: Mockable {
        // sourcery: value = 2
        var myVariable: Int { get }
    }
```

* **value**: the default value to be initilised with

#### protocol functions

```
    protocol Objectable: Mockable {
        // sourcery: returnValue = true
        func foo() -> Bool
    }
```

* **returnValue**: the default value to be returned when none are set via the `Actions` class

Note that all `NS` / `UI` objects will be automatically mocked with a default value, e.g. `var x = NSTextField()`. All variables whose type inherits from `Mockable` will also be mocked with a default value, e.g. `var x = MockObject()`.

## Known Issues

Nothing yet. Please report any issues you may find!

## Credits

This script has been adapted from `AutoMockable.stencil` by [Sourcery](https://github.com/krzysztofzablocki/Sourcery)

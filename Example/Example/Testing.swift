import Foundation

// sourcery: name = MyObject, inherits = NSObject
protocol Testing: Mockable {
	// sourcery: value = false
	var aVarible: Bool { get }
	// sourcery: returnValue = false
	func foo() -> Bool
}

class MyObject: Testing {
	var aVarible: Bool = false

	func foo() -> Bool {
		print("foo called")
		return true
	}
}

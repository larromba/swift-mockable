import Foundation

// sourcery: name = MyObject, inherits = NSObject
protocol MyObjectable: Mockable {
	// sourcery: value = false
	var aVarible: Bool { get }
	// sourcery: returnValue = false
	func foo() -> Bool
}

class MyObject: NSObject, MyObjectable {
	var aVarible: Bool = false

	func foo() -> Bool {
		print("foo called")
		return true
	}
}

import XCTest
@testable import Example

class ViewControllerTests: XCTestCase {
	func testFooCalledOnViewDidLoad() {
		// mocks
		let sut = MockMyObject()
		let viewController = ViewController()

		// setup
		viewController.myObject = sut

		// test
		viewController.viewDidLoad()
		XCTAssertTrue(sut.invocations.isInvoked(MockMyObject.funcs.foo1))
	}
}

import XCTest
@testable import Example

final class ViewControllerTests: XCTestCase {
	func test_viewDidLoad_whenInvoked_expectFooInvoked() {
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

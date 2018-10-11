//
//  ExampleTests.swift
//  ExampleTests
//
//  Created by Lee Arromba on 11/10/2018.
//

import XCTest
@testable import Example

class ExampleTests: XCTestCase {
	func testFooCalled() {
		// mocks
		let myObject = MockMyObject()
		let viewController = ViewController(nibName: nil, bundle: nil)

		// setup
		viewController.myObject = myObject

		// test
		viewController.viewDidLoad()
		XCTAssertTrue(myObject.invocations.isInvoked(MockMyObject.funcs.foo1))
	}
}

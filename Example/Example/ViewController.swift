import UIKit

class ViewController: UIViewController {
	var myObject: Testing = MyObject()

	override func viewDidLoad() {
		super.viewDidLoad()
		_ = myObject.foo()
	}
}

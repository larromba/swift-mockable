import UIKit

class ViewController: UIViewController {
	var myObject: MyObjectable = MyObject()

	override func viewDidLoad() {
		super.viewDidLoad()
		_ = myObject.foo()
	}
}

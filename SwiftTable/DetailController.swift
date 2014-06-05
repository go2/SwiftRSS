

import Foundation
import UIKit

class DetailController: UIViewController {

	var textView = UITextView()
	var feed = Dictionary<String, String>()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.whiteColor()
		self.title = "Feed"

		textView.font = UIFont(name: "Helvetica", size: 14)
		textView.editable = false
		textView.frame =  CGRectInset(self.view.bounds, 20, 20)
		self.view.addSubview(textView)

		textView.text = feed["description"]
		
		var rightBarButton = UIBarButtonItem(title: "Website", style: .Plain, target: self, action: "goToWebsite")
		navigationItem.setRightBarButtonItem(rightBarButton, animated: true)
		
	}
	
	func goToWebsite() {
		
		let webView = WebViewController()
		self.navigationController.pushViewController(webView, animated: true)
		webView.loadAddressURL(feed["link"]!)
	}
	
}

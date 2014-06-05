

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate {
	
   var webView = UIWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.whiteColor()
		webView.delegate = self;
		
        configureWebView()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        if UIApplication.sharedApplication().networkActivityIndicatorVisible {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }

	
	func loadAddressURL(address: String) {
        let requestURL = NSURL(string: address)
        let request = NSURLRequest(URL: requestURL)
        webView.loadRequest(request)
	}

    func configureWebView() {

		webView.frame =  CGRectInset(self.view.bounds, 20, 20)
		webView.backgroundColor = UIColor.whiteColor()
		webView.scalesPageToFit = true
		webView.dataDetectorTypes = .All
		
		self.view.addSubview(webView)
    }


    func webViewDidStartLoad(_: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }

    func webViewDidFinishLoad(_: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }

    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {

		let localizedErrorMessage = NSLocalizedString("An error occured:", comment: "")

        let errorHTML = "<!doctype html><html><body><div style=\"width: 100%%; text-align: center; font-size: 36pt;\">\(localizedErrorMessage) \(error.localizedDescription)</div></body></html>"

        webView.loadHTMLString(errorHTML, baseURL: nil)

        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }


}

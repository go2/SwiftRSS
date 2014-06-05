

import UIKit

class ViewController: UITableViewController, NSXMLParserDelegate {
	
	var feeds = Dictionary<String, String>[]() //array of dictionaries
	var feed = Dictionary<String, String>() //dictionary

	var feedTitle = ""
	var link = ""
	var feedDescription = ""
	var element = ""

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		request()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func request() {
		let URL = NSURL(string: "http://images.apple.com/main/rss/hotnews/hotnews.rss")
		let feedParser = NSXMLParser(contentsOfURL: URL);
		feedParser.delegate = self
		feedParser.shouldResolveExternalEntities = false
		feedParser.parse()
	}
	
	 func parserDidStartDocument(parser: NSXMLParser!) {
			feeds.removeAll(keepCapacity: false)
	}
	
	 func parserDidEndDocument(parser: NSXMLParser!) {
		self.tableView.reloadData()
	}
	
	 func parser(parser: NSXMLParser!,
		didStartElement elementName: String!,
		namespaceURI namespaceURI: String!,
		qualifiedName qualifiedName: String!,
		attributes attributeDict: NSDictionary!) {
			
			element = elementName

			if element == "item" {
				feed.removeAll(keepCapacity: false)
				feedTitle = ""
				link = ""
				feedDescription = ""
			}
	}

	func parser(parser: NSXMLParser!,
		foundCharacters string: String!) {
			
			if element == "title" {
				feedTitle += string
			} else if element == "link" {
				link += string
			} else if element == "description" {
				feedDescription += string
			}

	}
	
	 func parser(parser: NSXMLParser!,
		didEndElement elementName: String!,
		namespaceURI namespaceURI: String!,
		qualifiedName qName: String!) {
			
			if elementName == "item" {
				feed["title"] = feedTitle
				feed["description"] = feedDescription
				feed["link"] = link.componentsSeparatedByString("?")[0] as NSString
				feeds += feed
			}
	}
	
	
	override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
		return 30
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return feeds.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "FeedCell")
		self.configureCell(cell, atIndexPath: indexPath)
		return cell
	}

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let rowItem = feeds[indexPath.row] as Dictionary<String, String>
		
		let detailView = DetailController()
		detailView.feed = rowItem;

		self.navigationController.pushViewController(detailView, animated: true)
	}
	
	func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
		let rowItem = feeds[indexPath.row] as Dictionary<String, String>
		cell.textLabel.text = rowItem["title"]
		cell.textLabel.font = UIFont.systemFontOfSize(14.0)
		cell.textLabel.numberOfLines = 0
	}
	
}

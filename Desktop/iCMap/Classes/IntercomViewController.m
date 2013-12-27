//
//  IntercomViewController.m
//  iCMap
//
//  Created by Juan Duchimaza on 4/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IntercomViewController.h"
#import "iCMapAppDelegate.h"

@implementation IntercomViewController

- (void)viewDidLoad {
	
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	if ([stories count] == 0) { 
		NSString * path = @"http://www.ithaca.edu/profiles/feeds/intercom.xml";
		[self parseXMLFileAtURL:path]; // parseXMLFileAtURL is defined later.
	} 
	cellSize = CGSizeMake([newsTable bounds].size.width, 60); 
}


- (void)parseXMLFileAtURL:(NSString *)URL {
	stories = [[NSMutableArray alloc] init];
	
	// You must then convert the path to a proper NSURL or it won't work 
	NSURL *xmlURL = [NSURL URLWithString:URL]; 
	
	rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL]; 
	
	// Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks. 
	[rssParser setDelegate:(id < NSXMLParserDelegate >)self]; 
	
	// Enable fun features of NSXMLParser. 
	[rssParser setShouldProcessNamespaces:YES]; 
	[rssParser setShouldReportNamespacePrefixes:YES];
	[rssParser setShouldResolveExternalEntities:YES]; 
	
	[rssParser parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser { 
	NSLog(@"Found file and started parsing"); 
} 

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )",
							  [parseError code]]; NSLog(@"error parsing XML: %@", errorString); 
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" 
														  message:errorString delegate:self 
												cancelButtonTitle:@"OK" 
												otherButtonTitles:nil];
	[errorAlert show]; 
} 

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	currentElement = [elementName copy]; 
	if ([elementName isEqualToString:@"item"]) {
		// Clear out our story item caches... 
		item = [[NSMutableDictionary alloc] init]; 
		currentTitle = [[NSMutableString alloc] init]; 
		currentDate = [[NSMutableString alloc] init]; 
		currentSummary = [[NSMutableString alloc] init]; 
		currentLink = [[NSMutableString alloc] init]; 
	} 
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{ 
	if ([elementName isEqualToString:@"item"]) { 
		// Save values to an item... 
		[item setObject:currentTitle forKey:@"title"]; 
		[item setObject:currentLink forKey:@"link"]; 
		[item setObject:currentSummary forKey:@"summary"]; 
		[item setObject:currentDate forKey:@"date"]; 
		
		// Then store that item into the array
		[stories addObject:[item copy]]; 
		NSLog(@"Adding story: %@", currentTitle); 
	} 
} 

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{ 
	// Save the characters for the current item... 
	if ([currentElement isEqualToString:@"title"]) {
		[currentTitle appendString:string]; 
	} 
	else if ([currentElement isEqualToString:@"link"]) {
		[currentLink appendString:string]; 
	} 
	else if ([currentElement isEqualToString:@"description"]) { 
		[currentSummary appendString:string]; 
	} 
	else if ([currentElement isEqualToString:@"pubDate"]) {
		[currentDate appendString:string]; 
	} 
} 

- (void)parserDidEndDocument:(NSXMLParser *)parser 
{
	// Finished parsing the document
	[activityIndicator stopAnimating]; 
	[activityIndicator removeFromSuperview];
	[newsTable reloadData]; 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[currentElement release]; 
	[rssParser release]; 
	[stories release]; 
	[item release]; 
	[currentTitle release]; 
	[currentDate release];
	[currentSummary release]; 
	[currentLink release]; 
	[super dealloc];
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [stories count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
    if (cell == nil) {
		// UITableViewCellStyleSubtitle allows us to show a small preview of the story
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier] autorelease];
    }
    
	// Set up the cell	
	int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];

	NSString *titleTxt = [[stories objectAtIndex:storyIndex] objectForKey:@"title"];
	// The next two lines explicitly clean up the string for special characters (' and \)
	//	The same should be implemented for the summaryTxt
	titleTxt = [titleTxt stringByReplacingOccurrencesOfString:@"&#8217;" withString:@"\'"];
	titleTxt = [titleTxt stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
	[cell.textLabel setText:titleTxt];

	NSString *summaryTxt = [[stories objectAtIndex:storyIndex] objectForKey:@"summary"];
	summaryTxt = [self stripTags:summaryTxt]; // stripTags defined next!
	[cell.detailTextLabel setText:summaryTxt];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
    return cell;
}

// To remove HTML tags from the XML file
- (NSString *) stripTags:(NSString *)str
{
	NSMutableString *html = [NSMutableString stringWithCapacity:[str length]];
	
	NSScanner *scanner = [NSScanner scannerWithString:str];
	NSString *tempText = nil;
	
	while (![scanner isAtEnd])
	{
		[scanner scanUpToString:@"<" intoString:&tempText];
		
		if (tempText != nil)
			[html appendString:tempText];
		
		[scanner scanUpToString:@">" intoString:NULL];
		
		if (![scanner isAtEnd])
			[scanner setScanLocation:[scanner scanLocation] + 1];
		
		tempText = nil;
	}
	
	return html;
}
	

#pragma mark -

#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath { 
	// Navigation logic 
	int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	NSString * storyLink = [[stories objectAtIndex: storyIndex] objectForKey: @"link"]; 
	// Clean up the link - get rid of spaces, returns, and tabs... 
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@" " withString:@""]; 
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@"	" withString:@""]; 
	
	NSURL *url = [NSURL URLWithString:storyLink];
		
	// Open the story in Safari 
	[[UIApplication sharedApplication] openURL:url]; 

	/* trying to load the story within the view controller
	UIWebView *story;	
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[story	loadRequest:request];
	[self.view addSubview:story];
	 */

}

@end

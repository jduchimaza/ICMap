//
//  IntercomViewController.h
//  iCMap
//
//  Created by Juan Duchimaza on 4/23/11.
//  Copyright 2011 Ithaca College. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IntercomViewController : UITableViewController {
	IBOutlet UITableView * newsTable; 
	UIActivityIndicatorView * activityIndicator; 
	CGSize cellSize; NSXMLParser * rssParser; 
	NSMutableArray * stories; 
	
	// A temporary item; added to the "stories" array one at a time, and cleared for the next one 
	NSMutableDictionary * item; // it parses through the document, from top to bottom... 
	
	// We collect and cache each sub-element value, and then save each item to our array. 
	// We use these to track each current item, until it's ready to be added to the "stories" array 
	NSString * currentElement; 
	NSMutableString * currentTitle, * currentDate, * currentSummary, * currentLink;
	
}

-(NSString *)stripTags:(NSString *)str;
- (void)parseXMLFileAtURL:(NSString *)URL;


@end

//
//  IthacaWebViewController.m
//  iCMap
//
//  Created by Juan Duchimaza on 5/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IthacaWebViewController.h"


@implementation IthacaWebViewController
@synthesize webView;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad {
	NSString *urlAddress = @"http://www.ithaca.edu";
	// Create a URL object.
	NSURL *url = [NSURL URLWithString:urlAddress];
	// URL Requst Object
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	// Load the request in the UIWebView.
	[webView loadRequest:requestObj];
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
}


- (void)dealloc {
	[webView dealloc];
    [super dealloc];
}


@end

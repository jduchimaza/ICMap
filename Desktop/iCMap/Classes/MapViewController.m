//
//  MapViewController.m
//  iCMap
//
//  Created by Juan Duchimaza and Corey Jeffers on 4/15/11.
//  Copyright 2011 Ithaca College. All rights reserved.
//
// The map is shown as an image within a scrollView. Showing the image itself does not allow
//	panning or zooming. Placing the image within a scrollView allows user interaction for
//	taps and pinching.

#import "MapViewController.h"

#define ZOOM_STEP 1.5  // A constant for how much each zoom tap will zoom 


@implementation MapViewController
@synthesize scrollView, image;  


- (void)viewDidLoad {
	// Show an alert to welcome the user to the app. I (Juan) just think it looks neat... absolutely something 
	//	that is not needed... just a little perk.
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:@"Welcome to the Campus Map!" 
						  message:@"Play around with it - pinch and tap all you want. It's magical!" 
						  delegate:nil 
						  cancelButtonTitle:@"I want to explore!" 
						  otherButtonTitles:nil];
	[alert show];
	[alert release];
	
    [super viewDidLoad];
	
	scrollView.bouncesZoom = YES;  // Animates the content scaling when the scaling exceeds the maximum or minimum limits
	scrollView.delegate = self;	
	scrollView.clipsToBounds = YES;  
	
	// Initialize 'image' with the appropriate campus map image
	image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ithaca_College_Campus_Map.png"]];  
	image.userInteractionEnabled = YES;  
	image.autoresizingMask = ( UIViewAutoresizingFlexibleWidth );  
	[scrollView addSubview:image];  // Add the image to scrollView's view
	scrollView.contentSize = [image frame].size;

	// Define the behaviors for gestures (defined later in the file)
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];  
	UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];  
	UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];  

	[doubleTap setNumberOfTapsRequired:2];  
	[twoFingerTap setNumberOfTouchesRequired:2]; 
	
	[image addGestureRecognizer:singleTap];  
	[image addGestureRecognizer:doubleTap];  
	[image addGestureRecognizer:twoFingerTap];  
	[singleTap release];  
	[doubleTap release];  
	[twoFingerTap release];
	
	// Calculate scale to perfectly fit image height, that's as much as user can zoom out
	float minimumScale = [scrollView frame].size.height  / [image frame].size.height;  
	scrollView.maximumZoomScale = 2; // How much the user can zoom in
	scrollView.minimumZoomScale = minimumScale;  // How much the user can zoom out
	scrollView.zoomScale = 0.85;  // The starting scale of the image
	
	// Center the image on the scrollView so that we start the app in the middle of the map
	CGPoint centerImg; 
	centerImg.x = image.frame.size.width/3;
	centerImg.y = image.frame.size.height/3 ;
	scrollView.contentOffset = centerImg;

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
	self.scrollView = nil;  
	self.image = nil;  
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {  
	return image;  
} 


- (void)dealloc {
	[scrollView release];
	[image release];
    [super dealloc];
}

#pragma mark TapDetectingImageViewDelegate methods  

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {  
	// A single tap does nothing for now  
}  

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {  
	// If the user taps twice, the map zooms in  
	float newScale = [scrollView zoomScale] * ZOOM_STEP;  
	CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];  
	[scrollView zoomToRect:zoomRect animated:YES];  
}  

- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {  
	// If the finger taps with two fingers, the map zooms out  
	float newScale = [scrollView zoomScale] / ZOOM_STEP;  
	CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];  
	[scrollView zoomToRect:zoomRect animated:YES];  
}  

#pragma mark Utility methods  

// Zoom to a given scale to a given center point (useful for gesture recognition methods)
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {  
	
	CGRect zoomRect;  
	
	// The zoom rect is in the content view's coordinates.   
	//    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.  
	//    As the zoom scale decreases, so more content is visible, the size of the rect grows.  
	zoomRect.size.height = [scrollView frame].size.height / scale;  
	zoomRect.size.width  = [scrollView frame].size.width  / scale;  
	
	// Choose an origin so as to get the right center.  
	zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);  
	zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);  
	
	return zoomRect;  
}  


@end

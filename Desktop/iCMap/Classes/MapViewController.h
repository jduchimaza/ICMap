//
//  MapViewController.h
//  iCMap
//
//  Created by Juan Duchimaza on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MapViewController : UIViewController <UIScrollViewDelegate>{
	UIScrollView *scrollView;
	UIImageView *image;
}


@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;  
@property (nonatomic, retain) UIImageView *image; 

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;  

@end

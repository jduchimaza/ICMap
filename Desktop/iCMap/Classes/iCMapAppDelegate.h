//
//  iCMapAppDelegate.h
//  iCMap
//
//  Created by Juan Duchimaza on 4/15/11.
//  Copyright 2011 Ithaca College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarController.h"; // TabBarController controls the tab bar at the bottom of the app screen
#import "MapViewController.h";
#import "TourGuideViewController.h";
#import "IntercomViewController.h";
#import "IthacaWebViewController.h";

@interface iCMapAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *nav;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *nav;

@end


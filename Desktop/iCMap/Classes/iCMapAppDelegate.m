//
//  iCMapAppDelegate.m
//  iCMap
//
//  Created by Juan Duchimaza on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "iCMapAppDelegate.h"

@implementation iCMapAppDelegate

@synthesize window;
@synthesize nav;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	//The tab bar is subclassed so that the app can rotate. Traditionally, TabBar applications don't rotate.
	//	Although subclassing a tab bar is not recommended by Apple, it works well for the purposes of this app.
	//	The only requirement to allow a subclassed tab bar is to implement shouldAutorotateToInterfaceOrientation
	//	in all ViewControllers and have it return YES for the allowed orientations. 
	
	// Create a new MapViewController for the first tab - this will be the image of the campus
	UIViewController *tab1 = [[MapViewController alloc] init];
	// The tabBarItem (button) for the first tab will have the title "Campus Map" and have the appropriate image
    tab1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Campus Map" image:[UIImage imageNamed:@"map.png"] tag:0];
	
	
	// Create a new TourGuideViewController for the second tab - this will be google maps
    UIViewController *tab2 = [[TourGuideViewController alloc] init];
	// The button for the second tab will have the title "Tour Guide" and an appropriate image
    tab2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Tour Guide" image:[UIImage imageNamed:@"map-marker.png"] tag:1];

	
	// The initial goal with the Intercom tab was to implement a Nav controller:
	//	the root view would show a list of the intercom stories from the RSS
	//	the next view would show a UIWebView with the page of the story loaded

	// Create a UINavigationController with a rootViewController that is an IntercomViewController
	nav = [[UINavigationController alloc] initWithRootViewController:[[IntercomViewController alloc] init]];
	// Customize the appearance of the navigationBar
	nav.navigationBar.barStyle = UIBarStyleBlack; 
	nav.navigationBar.topItem.title = @"Intercom";
	// The navController is now assigned to a UIViewController (so that the tabBar can be added) 
	UIViewController *tab3 = nav;
	tab3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Intercom" image:[UIImage imageNamed:@"bullhorn.png"] tag:2];
	
	// Create the fourth tab view
	UIViewController *tab4 = [[IthacaWebViewController alloc] init];
	tab4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"ithaca.edu" image:[UIImage imageNamed:@"laptop.png"] tag:3];

	
	
    // Now create an instance of our rotating tab bar controller
    TabBarController *tbc = [[TabBarController alloc] init];
	
    // Add the view controllers to the tab bar
    [tbc setViewControllers:[NSArray arrayWithObjects:tab1, tab2, tab3, tab4, nil]];
	[tab1 release];
	[tab2 release];
	[tab3 release];
	[tab4 release];
	
    
    // Add the tab bar controller’s view to the window
    [window addSubview:tbc.view];
    
    // Make our program visible
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}



- (void)dealloc {
    [window release];
	[nav release];
    [super dealloc];
}


@end

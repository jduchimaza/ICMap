//
//  TourGuideViewController.h
//  iCMap
//
//  Created by Juan Duchimaza and Corey Jeffers on 4/15/11.
//  Copyright 2011 Ithaca College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "TGAnnotation.h"

@interface TourGuideViewController : UIViewController{

	IBOutlet MKMapView *mapView;
}

@property (retain, nonatomic) IBOutlet MKMapView *mapView;


-(void)loadOurAnnotations;

@end

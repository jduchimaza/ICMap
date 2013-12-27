//
//  TourGuideViewController.m
//  iCMap
//
//  Created by Juan Duchimaza on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TourGuideViewController.h"
#import "TGAnnotation.h"

@implementation TourGuideViewController

@synthesize mapView;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	MKCoordinateRegion region;
    MKCoordinateSpan span;
	CLLocationCoordinate2D location;

	// Set the coordinates of the center of the map
    location.latitude  = 42.42169;
    location.longitude = -76.495882;

	// Set how zoomed in we want to be initially
    span.latitudeDelta = 0.0025;
    span.longitudeDelta = 0.0025;
	
    region.span = span;
    region.center = location;

	// Customize the mapView
	[mapView setShowsUserLocation:YES]; 
    [mapView setRegion:region animated:YES];
    [mapView regionThatFits:region];
	
	//then drop in our pins!
	[self loadOurAnnotations];
}


-(void)loadOurAnnotations
{
	CLLocationCoordinate2D workingCoordinate;
	
	//Drop the pins for Dorms	
	//Landon
	workingCoordinate.latitude = 42.423575;
	workingCoordinate.longitude = -76.493779;
	TGAnnotation *landon = [[TGAnnotation alloc] initWithCoordinate:workingCoordinate];
	[landon setTitle:@"Landon Hall"];
	[landon setSubtitle:@"One of the quads"];
	[landon setAnnotationType:TGAnnotationTypeDorm];
	
	[mapView addAnnotation:landon];
	[landon release];
	
	//Bogart
	workingCoordinate.latitude = 42.423609;
	workingCoordinate.longitude = -76.492825;
	TGAnnotation *bogart = [[TGAnnotation alloc] initWithCoordinate:workingCoordinate];
	[bogart setTitle:@"Bogart Hall"];
	[bogart setSubtitle:@"One of the quads"];
	[bogart setAnnotationType:TGAnnotationTypeDorm];
	
	[mapView addAnnotation:bogart];
	[bogart release];
	
	//East Tower
	workingCoordinate.latitude = 42.420599;
	workingCoordinate.longitude = -76.494042;
	TGAnnotation *et = [[TGAnnotation alloc] initWithCoordinate:workingCoordinate];
	[et setTitle:@"East Tower"];
	[et setSubtitle:@"One of the towers"];
	[et setAnnotationType:TGAnnotationTypeDorm];
	
	[mapView addAnnotation:et];
	[et release];
	
	// Drop the pins for Dining Halls
	
	// Campus Center
	workingCoordinate.latitude = 42.422198;
	workingCoordinate.longitude = -76.493901;
	TGAnnotation *cc = [[TGAnnotation alloc] initWithCoordinate:workingCoordinate];
	[cc setTitle:@"Campus Center Dining Hall"];
	[cc setSubtitle:@"Vegan Food"];
	[cc setAnnotationType:TGAnnotationTypeDH];
	
	
	[mapView addAnnotation:cc];
	[cc release];
	
	// Towers
	workingCoordinate.latitude = 42.420675;
	workingCoordinate.longitude = -76.494639;
	TGAnnotation *towers = [[TGAnnotation alloc] initWithCoordinate:workingCoordinate];
	[towers setTitle:@"Towers Dining Hall"];
	[towers setSubtitle:@"Organic Food"];
	[towers setAnnotationType:TGAnnotationTypeDH];
	
	[mapView addAnnotation:towers];
	[towers release];
	
	// Terraces
	workingCoordinate.latitude = 42.419795;
	workingCoordinate.longitude = -76.496273;
	TGAnnotation *terraces = [[TGAnnotation alloc] initWithCoordinate:workingCoordinate];
	[terraces setTitle:@"Terrace Dining Hall"];
	[terraces setSubtitle:@"Kosher Food"];
	[terraces setAnnotationType:TGAnnotationTypeDH];
	
	[mapView addAnnotation:terraces];
	[terraces release];
	
	
	// Drop the pins for Academic Buildings
	
	// Williams Hall
	workingCoordinate.latitude = 42.422689;
	workingCoordinate.longitude = -76.495162;
	TGAnnotation *williams = [[TGAnnotation alloc] initWithCoordinate:workingCoordinate];
	[williams setTitle:@"Williams"];
	[williams setSubtitle:@"Math, CS, Psych"];
	[williams setAnnotationType:TGAnnotationTypeAcad];
	
	[mapView addAnnotation:williams];
	[williams release];
	
	// CHS
	workingCoordinate.latitude = 42.420040;
	workingCoordinate.longitude = -76.498000;
	TGAnnotation *chs = [[TGAnnotation alloc] initWithCoordinate:workingCoordinate];
	[chs setTitle:@"Center for Health Sciences"];
	[chs setSubtitle:@"Health Science and Human Performance"];
	[chs setAnnotationType:TGAnnotationTypeAcad];
	
	[mapView addAnnotation:chs];
	[chs release];
	
	// Whalen
	workingCoordinate.latitude =  42.420987;
	workingCoordinate.longitude = -76.495858;
	TGAnnotation *whalen = [[TGAnnotation alloc] initWithCoordinate:workingCoordinate];
	[whalen setTitle:@"Whalen"];
	[whalen setSubtitle:@"Music"];
	[whalen setAnnotationType:TGAnnotationTypeAcad];

	[mapView addAnnotation:whalen];
	[whalen release];
}

- (MKAnnotationView*) mapView:(MKMapView *)_mv viewForAnnotation:(id <MKAnnotation>)annotation {
    MKPinAnnotationView* view = nil;
	
	// To handle the annotation of user location
	if ([annotation isKindOfClass:MKUserLocation.class]) 
		return nil;
	
	// If the annotation isn't of the user location, make it a TGAnnotation
	TGAnnotation *myAnnotation = (TGAnnotation *)annotation;
	
	if(myAnnotation.annotationType == TGAnnotationTypeDorm)
	{
		NSString *identifier = @"Dorm";
		
		if(nil == view) {
			view = [[[MKPinAnnotationView alloc]
					 initWithAnnotation:myAnnotation
					 reuseIdentifier:identifier]
					autorelease];
		}
		
		// Assign a pin color to TGAnnotationTypeDorm (red)
		[view setPinColor:MKPinAnnotationColorRed];
		[view setAnimatesDrop:YES];
		[view setCanShowCallout:YES];
		[identifier release];
	}
	
	if(myAnnotation.annotationType == TGAnnotationTypeDH)
	{
		NSString *identifier = @"Dining Hall";
		
		if(nil == view) {
			view = [[[MKPinAnnotationView alloc]
					 initWithAnnotation:myAnnotation
					 reuseIdentifier:identifier]
					autorelease];
		}

		// Assign a pin color to TGAnnotationTypeDH (purple)
		[view setPinColor:MKPinAnnotationColorPurple];
		[view setAnimatesDrop:YES];
		[view setCanShowCallout:YES];
		
		[identifier release];
	}

	if(myAnnotation.annotationType == TGAnnotationTypeAcad)
	{
		NSString *identifier = @"Academic Building";
		
		if(nil == view) {
			view = [[[MKPinAnnotationView alloc]
					 initWithAnnotation:myAnnotation
					 reuseIdentifier:identifier]
					autorelease];
		}
		
		// Assign a pin color to TGAnnotationTypeAcad (green)
		[view setPinColor:MKPinAnnotationColorGreen];
		[view setAnimatesDrop:YES];
		[view setCanShowCallout:YES];
		
		[identifier release];
	}
	
    return view;
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
	mapView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[mapView dealloc];
    [super dealloc];
}


@end

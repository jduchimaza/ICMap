//
//  TGAnnotation.m
//  iCMap
//
//  Created by Juan Duchimaza on 5/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TGAnnotation.h"


@implementation TGAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize annotationType;

-init
{
	return self;
}

-initWithCoordinate:(CLLocationCoordinate2D)inCoord
{
	coordinate = inCoord;
	return self;
}

@end

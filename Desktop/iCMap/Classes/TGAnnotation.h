//
//  TGAnnotation.h
//  iCMap
//
//  Created by Juan Duchimaza and Corey Jeffers on 5/9/11.
//  Copyright 2011 Ithaca College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef enum {
	TGAnnotationTypeDorm = 0,
	TGAnnotationTypeDH = 1,
	TGAnnotationTypeAcad = 2
} TGAnnotationType;

@interface TGAnnotation : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
	TGAnnotationType annotationType;
}
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *subtitle;
@property (nonatomic) TGAnnotationType annotationType;

@end

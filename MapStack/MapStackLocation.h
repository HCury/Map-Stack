//
//  MapStackLocation.h
//  MapStack
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapStackLocation : NSObject<MKAnnotation>

@property (nonatomic, strong) NSString               *name;
@property (nonatomic, copy)   NSString               *title;
@property (nonatomic, assign) CGFloat                latitude;
@property (nonatomic, assign) CGFloat                longitude;
@property (nonatomic, assign) NSInteger              distance;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) UIImage                *image;

@end

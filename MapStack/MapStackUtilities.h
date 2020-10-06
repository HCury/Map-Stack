//
//  MapStackUtilities.h
//  MapStack
//
//

#import <Foundation/Foundation.h>

@interface MapStackUtilities : NSObject

+(MapStackUtilities *)sharedSingleton;

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

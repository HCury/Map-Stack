/**
 Globals are bad, but the pattern is here if you want to use it.  There are a few exceptions, such as a global boolean indicating whether a user is logged in or out.
 */

#import "MapStackUtilities.h"

@implementation MapStackUtilities

@synthesize dictionary;

static MapStackUtilities* _sharedSingleton = nil;

//class method for getting and setting the singleton
+(MapStackUtilities *)sharedSingleton
{
    static dispatch_once_t pred;
    static MapStackUtilities *instance = nil;
    dispatch_once(&pred, ^{instance = [[self alloc]init];});
    return instance;
}

+(id)alloc
{
    //makes sure alloc is not called again before this method finishes
    @synchronized([MapStackUtilities class])
    {
        NSAssert(_sharedSingleton == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedSingleton = [super alloc];
        return _sharedSingleton;
    }
    
    return nil;
}

-(id)init {
    self = [super init];
    
    if (self != nil) {
        dictionary = [[NSMutableDictionary alloc]init];
    }
    
    return self;
}

@end

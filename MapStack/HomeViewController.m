//
//  HomeViewController.m
//  MapStack
//
//

#import "HomeViewController.h"
#import <MapKit/MapKit.h>
#import "MapStackLocation.h"

@interface HomeViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) NSMutableArray *locationsArray;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSURLSession *sessionLocation;
@end

@implementation HomeViewController

- (void)viewDidLoad {
   // NSLog(@"viewdidload home");
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBackground:) name:@"changeBackground" object:nil];
    
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager setDelegate:self];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 25.777599;
    coordinate.longitude = -80.190793;
    
    MKCoordinateRegion adjustedRegion = [self.map regionThatFits:MKCoordinateRegionMakeWithDistance(coordinate, 1200, 1200)];
    [self.map setRegion:adjustedRegion animated:YES];
    
    self.locationsArray = [NSMutableArray array];
    
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.sessionLocation = [NSURLSession sessionWithConfiguration:config];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    NSLog(@"viewwillappear home");
//    
//    /**
//     make sure our little data store is empty
//     */
//    [self.locationsArray removeAllObjects];
//    
//    /**
//     grab the local json file
//     */
//    
//    NSString *jsonFile = [[NSBundle mainBundle] pathForResource:@"MapStackLocations" ofType:@"json"];
//    /**
//     convert it to bytes
//     */
//    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFile];
//    //NSLog(@"jsonData: %@", jsonData);
//    
//    /**
//     convert the bytes to json
//     */
//    NSError *error;
//    id jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
//    
//    if (error)
//    {
//        NSLog(@"json error: %@", error.description);
//        return;
//    }
//    
//    NSArray *arr = [jsonResponse objectForKey:@"MapStackLocationsArray"];
//    
//    /**
//     Create a mapstacklocation object for each json object
//     */
//    NSLog(@"array: %@", arr);
//    
//    for (NSInteger i = 0; i < arr.count; i++)
//    {
//        [self createLocations:arr[i]];
//    }
//    
//    /**
//     broadcast that the data is ready
//     */
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"mapLocationsDidChange" object:self.locationsArray userInfo:nil];
//    
//    /**
//     Save the data to a local Parse datastore if it hasn't been saved already
//     */
//    //bool saved = [[NSUserDefaults standardUserDefaults] boolForKey:@"locationsSavedKey"];
//    
//}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.locationsArray removeAllObjects];
    
    NSURL *url = [NSURL URLWithString:@"http://mikeleveton.com/MapStackLocations.json"];
    
    NSMutableURLRequest *locationsRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSURLSessionDataTask *locationTask = [self.sessionLocation dataTaskWithRequest:locationsRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        if (!error)
        {
            NSError *error;
            
            id jsonResponse = [NSJSONSerialization
                               JSONObjectWithData:data
                               options:NSJSONReadingMutableContainers
                               error:&error];
            
            if (error)
            {
               // NSLog(@"error: %@", error.description);
                return;
                
            
            }
            
           // NSLog(@"jsonResponse: %@", jsonResponse);
            
            NSArray *arr = [jsonResponse objectForKey:@"MapStackLocationsArray"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.spinner.hidesWhenStopped = YES;
                [self.spinner stopAnimating];
                
                
                
                for (NSInteger i = 0; i < arr.count; i++)
                {
                    [self createLocations:arr[i]];
                }
                
                NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"title"
                                                                                 ascending:YES];
                NSArray *sorted = [self.locationsArray sortedArrayUsingDescriptors:@[sortDescriptor]];
                [self.locationsArray removeAllObjects];
                [self.locationsArray addObjectsFromArray:sorted];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"mapLocationsDidChange" object:self.locationsArray userInfo:nil];
                
                NSLog(@"Reached End of Block");
                
            });
            
        }
        
    }];
    
    [locationTask resume];
    
    NSLog(@"REACHED END OF VIEWWILLAPPEAR");
    [self.spinner startAnimating];
}

- (void)createLocations:(NSDictionary *)dict{
    
    MapStackLocation *location = [[MapStackLocation alloc]init];
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[dict objectForKey:@"latitude"] floatValue];
    coordinate.longitude = [[dict objectForKey:@"longitude"] floatValue];
    location.coordinate = coordinate;
    
    location.name = [dict objectForKey:@"name"];
    location.title = [dict objectForKey:@"name"];
    location.latitude = [[dict objectForKey:@"latitude"] floatValue];
    location.longitude = [[dict objectForKey:@"longitude"] floatValue];
    location.distance = [[dict objectForKey:@"distance"] integerValue];
    
    UIImage *image = [UIImage imageNamed:[dict objectForKey:@"image"]];
    location.image = image;
    
    [self.map addAnnotation:location];
    [self.locationsArray addObject:location];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - utilities

- (void)changeBackground:(NSNotification *)note{
    UIColor *color = [note object];
    [self.view setBackgroundColor:color];

}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
  //  NSLog(@"map view lat: %f", mapView.region.center.latitude);
    
    
}

- (void)mapViewWillStartRenderingMap:(MKMapView *)mapView{
   // NSLog(@"map view long: %f", mapView.region.center.longitude);
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *pinView = nil;
    
    if (annotation != self.map.userLocation)
    {
        static NSString *defaultPinID = @"com.mapstack.pin";
        
        pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        
        if (pinView == nil)
        {
            pinView = [[MKAnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        }
        
        pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        pinView.canShowCallout = YES;
        pinView.userInteractionEnabled = YES;
        pinView.image = [UIImage imageNamed:@"MapStackPin"];
    }
    
    return pinView;
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
  //  NSLog(@"status: %ld", (long)status);
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
   // NSLog(@"locations %@", locations);
}
@end

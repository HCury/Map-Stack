//
//  LocationsViewController.m
//  MapStack
//
//

#import "LocationsViewController.h"
#import "HomeViewController.h"
#import "MapStackCell.h"
#import "MapStackLocation.h"
#import "DetailViewController.h"

@interface LocationsViewController ()<UITableViewDataSource, UITableViewDelegate, MapStackCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation LocationsViewController

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
   //     NSLog(@"init locations");
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUpLocationsArray:) name:@"mapLocationsDidChange" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeColorWasSet:) name:@"userDidSelectThemeColor" object:nil];
    }
    return self;
}

- (void)themeColorWasSet:(NSNotification *)note{
    [self.tableView reloadData];
}

- (void)viewDidLoad {
  //  NSLog(@"view did load locations");
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor yellowColor]];
    
    CGRect viewFrame = self.view.frame;
    viewFrame.size.height = viewFrame.size.height - (49);
    
    self.tableView = [[UITableView alloc]initWithFrame:viewFrame];
    [self.tableView setDelegate:self];
    self.tableView.delegate = self;
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - utilities

- (void)setUpLocationsArray:(NSNotification *)note{
    self.dataSource = [note object];
    [self.tableView reloadData];
  //  NSLog(@"anObject: %@", self.dataSource);
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  //  NSLog(@"cell for row");
    
    MapStackCell *cell = [[MapStackCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"locationsCell"];
    if (cell == nil){
     //   NSLog(@"cell is nil!!!");
    }
    
    cell.delegate = self;
    [cell setIndexPath:indexPath];
    MapStackLocation *location = [self.dataSource objectAtIndex:indexPath.row];
    [cell.textLabel setText:location.name];
    //UIColor *color = [[NSUserDefaults standardUserDefaults] objectForKey:@"kMapStackChosenColor"];
    UIColor *color = [[MapStackUtilities sharedSingleton].dictionary objectForKey:@"kMapStackChosenColor"];
    [cell.textLabel setTextColor:color];
    
    NSString *distanceString = [NSString stringWithFormat:@"distance: %ld", (long)location.distance];
    [cell.detailTextLabel setText:distanceString];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setUpRightSideView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *vc = [DetailViewController new];
    
    [vc setLocation:[self.dataSource objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:vc animated:YES];

}




#pragma mark - MapStackCellDelegate

- (void)mapStackCell:(MapStackCell *)cell WasTappedWithIndex:(NSIndexPath *)indexPath{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBackground" object:[UIColor orangeColor] userInfo:nil];
}



@end

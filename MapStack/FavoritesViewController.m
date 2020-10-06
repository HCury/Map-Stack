//
//  FavoritesViewController.m
//  MapStack
//
//

enum {
    kFavoritesViewControllerHospitals = 0,
    kFavoritesViewControllerRestaurants,
    kFavoritesViewControllerClinics,
};

#import "FavoritesViewController.h"
#import "AnotherDetailViewController.h"

@interface FavoritesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (nonatomic, strong) NSMutableArray *section0DataSource;
@property (nonatomic, strong) NSMutableArray *section1DataSource;
@property (nonatomic, strong) NSMutableArray *section2DataSource;
@property (nonatomic, strong) NSMutableArray *locationsArray;

@property (nonatomic, strong) UIBarButtonItem *editButton;
@property (nonatomic, strong) UIBarButtonItem *saveButton;

@property (nonatomic, strong) NSIndexPath *section0IndexPath;
@property (nonatomic, strong) NSIndexPath *section1IndexPath;


@end

@implementation FavoritesViewController


-(id) initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleLocations:) name:@"mapLocationsDidChange" object:nil];
        self.locationsArray = [NSMutableArray array];
    }
    return self;
}

-(void) handleLocations: (NSNotification *)note{
    self.locationsArray = [note object];
    [self.table reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.section0DataSource = [[NSMutableArray alloc]initWithObjects:@"One", @"Two", @"Three", nil];
    _section1DataSource = [NSMutableArray arrayWithArray:self.section0DataSource];
    self.section2DataSource = [[NSMutableArray alloc]initWithObjects:@"Red", @"Green", @"Blue", nil];
    
    [[self navigationItem] setRightBarButtonItem:[self editButton]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == kFavoritesViewControllerHospitals){
        return self.section0DataSource.count;
    }
    if (section == kFavoritesViewControllerRestaurants){
        return _section1DataSource.count;
    }
    if (section == kFavoritesViewControllerClinics){
        return [self.locationsArray count];
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2){
    MapStackLocation *location = [self.locationsArray objectAtIndex:indexPath.row];

        AnotherDetailViewController *vc = [[AnotherDetailViewController alloc]initWithNibName: @"AnotherDetailViewController" bundle: nil];
        [vc setLocation:location];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section < 2){
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"locationsCell"];
        if (cell == nil){
            NSLog(@"cell is nil!!!");
        }
        
        //[cell.textLabel setText:[NSString stringWithFormat:@"cell row %ld", (long)indexPath.row]];
        
        if (indexPath.section == kFavoritesViewControllerHospitals){
            [cell.textLabel setText:[self.section0DataSource objectAtIndex:indexPath.row]];
        }
        if (indexPath.section == kFavoritesViewControllerRestaurants){
            [cell.textLabel setText:[self.section1DataSource objectAtIndex:indexPath.row]];
        }
        if (indexPath.section == kFavoritesViewControllerClinics){
            [cell.textLabel setText:[self.section2DataSource objectAtIndex:indexPath.row]];
        }
        
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"cell section %ld", (long)indexPath.section]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        if (indexPath.section == 0 && indexPath.row == 0){
            
            _section0IndexPath = indexPath;
            
        }
        
        if (indexPath.section == 1 && indexPath.row == 0){
            
            _section1IndexPath = indexPath;
        }
        
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"locationsCell"];
        if (cell == nil){
            NSLog(@"cell is nil!!!");
        }
        
        MapStackLocation *location = [self.locationsArray objectAtIndex:indexPath.row];
        [cell.textLabel setText:location.title];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"distance %ld", (long)location.distance]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == kFavoritesViewControllerHospitals){
        return @"Schools";
    }
    if (section == kFavoritesViewControllerRestaurants){
        return @"Restaurants";
    }
    if (section == kFavoritesViewControllerClinics){
        return @"Clinics and hospitals";
    }
    
    return @"places";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == kFavoritesViewControllerHospitals){
            [_section0DataSource removeObjectAtIndex:indexPath.row];
        }
        if (indexPath.section == kFavoritesViewControllerRestaurants){
            [_section1DataSource removeObjectAtIndex:indexPath.row];
        }
        if (indexPath.section == kFavoritesViewControllerClinics){
            [_section2DataSource removeObjectAtIndex:indexPath.row];
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


#pragma mark - views

-(UIBarButtonItem *)editButton{
    if( !_editButton){
        _editButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(didTapEdit:)];
        return _editButton;
    
    }
    return _editButton;
}


- (UIBarButtonItem *)saveButton{
    if( !_saveButton){
        _saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(didTapSave:)];
        return _saveButton;
        
    }
    return _saveButton;
}


- (void)didTapEdit:(UIBarButtonItem *)sender{
    [self.table setEditing:YES animated:YES];
    
    [self.table beginUpdates];
    if (_section0IndexPath){
        
        [self.section0DataSource addObject:@"zero"];
        [self.table insertRowsAtIndexPaths:[NSArray arrayWithObject:_section0IndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
           }
    
    if (_section1IndexPath){
        [self.section1DataSource removeObjectAtIndex:0];
        [self.table deleteRowsAtIndexPaths:[NSArray arrayWithObject:_section1IndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    [self.table endUpdates];
    
    [[self navigationItem] setRightBarButtonItem:[self saveButton]];
}

-(void)didTapSave: (id)sender{
    
    [self.table setEditing:NO animated:YES];
    
    [self.table beginUpdates];
    [self.table endUpdates];
    
    [[self navigationItem] setRightBarButtonItem:[self editButton]];

}

@end


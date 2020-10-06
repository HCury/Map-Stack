//
//  SettingsViewController.m
//  MapStack
//
//

#import "SettingsViewController.h"

enum{
    kSettingsViewThemeCollection = 0,
    kSettingsViewTypeCollection,
};

@interface SettingsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionView *typeCollection;
@property (strong, nonatomic) NSMutableArray *themeCollectionDataSource;
@property (strong, nonatomic) NSMutableArray *typeCollectionDataSource;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewType;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.typeCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 138, 320, 335) collectionViewLayout:[UICollectionViewLayout new]];
    [self.typeCollection setDelegate:self];
    [self.typeCollection setDataSource:self];
    [self.typeCollection setBackgroundColor:[UIColor clearColor]];
    //[self.view addSubview:self.typeCollection];
    
    UIColor *redColor = [UIColor redColor];
    UIColor *greenColor = [UIColor greenColor];
    UIColor *blueColor = [UIColor blueColor];
    UIColor *orangeColor = [self colorWithHexString:@"#fb9058" withOpacity:1.0];
    UIColor *offWhite = [self colorWithHexString:@"#f3f9ff" withOpacity:1.0];
    UIColor *magenta = [self colorWithHexString:@"#ff00ff" withOpacity:1.0];
    
    
    self.themeCollectionDataSource = [NSMutableArray arrayWithObjects:redColor, greenColor, blueColor, orangeColor, offWhite, magenta, nil];
    
    self.typeCollectionDataSource = [NSMutableArray arrayWithObjects:@"Hospitals", @"Schools", @"restaurants", @"bars", @"startup collectives", nil];
    
    [self.collectionView setHidden:YES];
    [self.collectionViewType setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTapControl:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == kSettingsViewTypeCollection){
        [self.collectionView setHidden:NO];
        [self.collectionViewType setHidden:YES];
    }
    if (sender.selectedSegmentIndex == kSettingsViewThemeCollection){
        [self.collectionView setHidden:YES];
        [self.collectionViewType setHidden:NO];
    }
    
    
}

- (NSInteger)collectionView:(UICollectionView * _Nonnull)collectionView
     numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == self.collectionView){
        return self.themeCollectionDataSource.count;
    }else{
        return self.typeCollectionDataSource.count;
    }
}

- (UICollectionViewCell * _Nonnull)collectionView:(UICollectionView * _Nonnull)collectionView
                           cellForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath{
    
    if (collectionView == self.collectionView){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
        [cell setBackgroundColor:[self.themeCollectionDataSource objectAtIndex:indexPath.row]];
        
        return cell;
    }else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TypeCell" forIndexPath:indexPath];
        if ((indexPath.row % 2) == 0){
            [cell setBackgroundColor:[UIColor yellowColor]];
        }else{
            [cell setBackgroundColor:[UIColor orangeColor]];
        }
        //[cell setBackgroundColor:[UIColor blueColor]];
        UILabel *typeLabel = [[UILabel alloc]initWithFrame:cell.frame];
        [typeLabel setNumberOfLines:0];
        [typeLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:10.0f]];
        [typeLabel setTextAlignment:NSTextAlignmentCenter];
        [typeLabel setText:[self.typeCollectionDataSource objectAtIndex:indexPath.row]];
        [cell addSubview:typeLabel];
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // If you need to use the touched cell, you can retrieve it like so
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    NSLog(@"touched cell %@ at indexPath %@", cell, indexPath);
    if (collectionView == _collectionView){
        UIColor *color = [self.themeCollectionDataSource objectAtIndex:indexPath.row];
        [self.view setBackgroundColor:color];
        //[[NSUserDefaults standardUserDefaults] setObject:color forKey:@"kMapStackChosenColor"];
        [[MapStackUtilities sharedSingleton].dictionary setObject:color forKey:@"kMapStackChosenColor"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userDidSelectThemeColor" object:nil userInfo:nil];
    }else{
        
    }
}


- (UIColor *)colorWithHexString:(NSString *)hex withOpacity:(CGFloat)opacity {
    //added in removal of # if passed into the string
    hex = [hex stringByReplacingOccurrencesOfString:@"#" withString:@"" options:0 range:NSMakeRange(0, [hex length])];
    
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha: opacity];
}

@end

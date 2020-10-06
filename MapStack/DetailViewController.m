//
//  DetailViewController.m
//  MapStack
//
//

#import "DetailViewController.h"

#define kViewPadding (20.0f)

@interface DetailViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    NSLog(@"viewWillLayoutSubviews called in detail");
    
    CGRect frame = [self.view frame];
    frame.origin.y = 64.0f + kViewPadding;
    frame.size.height = 50.0f;
    [[self titleLabel] setFrame:frame];
    
    CGRect imageFrame = [[self imageView] frame];
    imageFrame.origin.y = CGRectGetMaxY(frame);
    CGFloat xOffset = (frame.size.width - 300)/2;
    imageFrame.origin.x = xOffset;
    imageFrame.size.height = 300.0f;
    imageFrame.size.width = 300.0f;
    [[self imageView] setFrame:imageFrame];
    
    CGRect distanceFrame = [[self distanceLabel] frame];
    distanceFrame.origin.y = CGRectGetMaxY(imageFrame) + kViewPadding;
    distanceFrame.origin.x = 0.0f;
    distanceFrame.size.height = 50.0f;
    distanceFrame.size.width = frame.size.width;
    [[self distanceLabel] setFrame:distanceFrame];
    
    
    
}

#pragma mark - getters

- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:_titleLabel];
        return _titleLabel;
    }
    
    return _titleLabel;
}

- (UILabel *)distanceLabel{
    if (!_distanceLabel){
        _distanceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [_distanceLabel setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:_distanceLabel];
        return _distanceLabel;
    }
    
    return _distanceLabel;
}

- (UIImageView *)imageView{
    if (!_imageView){
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_imageView];
        return _imageView;
    }
    
    return _imageView;
}

#pragma mark - setters

- (void)setLocation:(MapStackLocation *)location{
    _location = location;
    
    [[self titleLabel] setText:location.title];
    NSString *distanceString = [NSString stringWithFormat:@"distance: %ld", (long)location.distance];
    [[self distanceLabel] setText:distanceString];
    [[self imageView] setImage:location.image];
}

@end

//
//  AnotherDetailViewController.m
//  MapStack
//
//

#import "AnotherDetailViewController.h"

@interface AnotherDetailViewController ()
@property (nonatomic, strong) UIView *panView;
@end

@implementation AnotherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    UILabel *label = (UILabel *)[self.view viewWithTag:1];
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:2];
    
    [label setText:self.location.title];
    [imageView setImage:self.location.image];
    
        self.panView = [[UIView alloc]init];
        CGRect frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height - 159, [UIScreen mainScreen].bounds.size.width - 20, 100);
        [        self.panView setFrame:frame];
        [        self.panView setBackgroundColor:[UIColor redColor]];
        [        self.panView setUserInteractionEnabled:YES];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        pan.enabled = YES;
        
        [        self.panView addGestureRecognizer:pan];
        [self.view addSubview:_panView];

    }

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    UIImageView *imageView = (UIImageView*)[self.view viewWithTag:2];
    CGRect frame = imageView.frame;
    frame.origin.y = frame.origin.y + 250;
    
    [UIView animateWithDuration:0.8
                          delay:0.2
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [imageView setFrame:frame];
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"animation finished");
                     }];
    
    NSLog(@"viewDidApper finished");
}

- (void) handlePan: (UIPanGestureRecognizer *)pan{
    pan.view.center = [pan locationInView:pan.view.superview];
}
   
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handlePinch:(id)sender {
    NSLog(@"pinch");
    UIPinchGestureRecognizer *pinch = (UIPinchGestureRecognizer *)sender;
    
    
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
    pinch.scale = 1;

}


@end

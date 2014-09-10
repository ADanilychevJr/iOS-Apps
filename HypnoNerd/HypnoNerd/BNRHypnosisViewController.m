//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by Alex Danilychev, Jr. on 7/10/14.
//  Copyright (c) 2014 Alex Danilychev, Jr. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController () <UITextFieldDelegate>

@end
@implementation BNRHypnosisViewController

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        self.tabBarItem.title = @"Hypnotize";
        //Didn't have an image to use for the tab
    }
    return self;
}

- (void) loadView
{
    /**
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Red", @"Green", @"Blue"]];
    segmentedControl.frame = CGRectMake(20, 380, 280, 30);
    segmentedControl.backgroundColor = [UIColor whiteColor];
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    **/ //Shows how to add a SegmentedControl as a subview of the Hypnosis View
    
    
    //Create a View
    CGRect frame = [UIScreen mainScreen].bounds;
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] initWithFrame:frame];
    
    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    [backgroundView addSubview:textField];
    textField.delegate = self;
    
    //[backgroundView addSubview:segmentedControl];
    self.view = backgroundView;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"BNR Hypnosis View Controller loaded");
}

-(BOOL) textFieldShouldReturn:(UITextField *) textField
{
    [self drawHypnoticMessage:textField.text];
    textField.text = @"";
    return true;
}

-(void) drawHypnoticMessage:(NSString *) message
{
    for (int i = 0; i < 20; i++){
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.text = message;
        
        [messageLabel sizeToFit]; //This fits it to the text thats been entered
        
        int width = (int) (self.view.bounds.size.width - messageLabel.bounds.size.width);
        int x = arc4random() % width;
        int height = (int) (self.view.bounds.size.height - messageLabel.bounds.size.height);
        int y = arc4random() % height;
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        [self.view addSubview:messageLabel];
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                       type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                       type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
    }
}

-(IBAction)segmentAction:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSLog(@"Segment clicked %d", segmentedControl.selectedSegmentIndex);
    BNRHypnosisView *hv = (BNRHypnosisView *) segmentedControl.superview;
    NSInteger i = segmentedControl.selectedSegmentIndex;
    if (i == 0){
        hv.circleColor = [UIColor redColor];
    } else if (i == 1){
        hv.circleColor = [UIColor greenColor];
    } else {
        hv.circleColor = [UIColor blueColor];
    }
}
@end

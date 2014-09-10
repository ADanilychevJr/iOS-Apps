//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Alex Danilychev, Jr. on 7/9/14.
//  Copyright (c) 2014 Alex Danilychev, Jr. All rights reserved.
//

#import "BNRHypnosisView.h"

@interface BNRHypnosisView ()



@end

@implementation BNRHypnosisView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    float maxRadius = hypot(bounds.size.width, bounds.size.height);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius-=20){
        [path moveToPoint:CGPointMake(center.x+currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0 endAngle:M_PI * 2.0 clockwise:YES];
    }
    path.lineWidth=10;
    [self.circleColor setStroke]; //This gets a lightGrayColor UIColor and setsStroke to that
    [path stroke];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ Was touched", self);
    float red = (arc4random() %100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    self.circleColor = randomColor;
}

- (void) setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}


@end

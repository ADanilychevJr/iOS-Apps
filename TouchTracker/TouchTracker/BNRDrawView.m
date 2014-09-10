//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by Alex Danilychev, Jr. on 7/30/14.
//  Copyright (c) 2014 Alex Danilychev, Jr. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView ()

@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;
    

@end
@implementation BNRDrawView

-(instancetype) initWithFrame:(CGRect)r
{
    self = [super initWithFrame:r];
    if (self){
        self.finishedLines = [[NSMutableArray alloc]init];
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.backgroundColor = [UIColor grayColor];
    }
    self.multipleTouchEnabled = YES;
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Lets put in a log statement to track the order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));
    for (UITouch *t in touches){
        CGPoint location = [t locationInView:self];
        BNRLine *line = [[BNRLine alloc] init];
        line.begin = location;
        line.end = location;
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }
    
    
    
    [self setNeedsDisplay];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Log statement to track order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));
    for (UITouch *t in touches){
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        line.end = [t locationInView:self];
    }
    [self setNeedsDisplay];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Log statement to track order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));
    for (UITouch *t in touches){
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
    }
    
    [self setNeedsDisplay];
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Log statement to track order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));
    for (UITouch *t in touches){
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [self.linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

-(void) strokeLine:(BNRLine *) line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

-(void) drawRect:(CGRect)rect
{
    //Draw finished lines in black
    [[UIColor blackColor] set];
    for (BNRLine *line in self.finishedLines){
        [self strokeLine:line];
    }
    [[UIColor redColor] set];
    for (NSValue *key in self.linesInProgress){
        [self strokeLine:self.linesInProgress[key]];
    }
}


@end

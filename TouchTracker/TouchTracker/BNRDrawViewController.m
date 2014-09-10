//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by Alex Danilychev, Jr. on 7/30/14.
//  Copyright (c) 2014 Alex Danilychev, Jr. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

-(void) loadView
{
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}

@end

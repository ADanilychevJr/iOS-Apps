//
//  main.m
//  Random Items
//
//  Created by Alex Danilychev, Jr. on 7/7/14.
//  Copyright (c) 2014 Alex Danilychev, Jr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        BNRItem *backpack = [[BNRItem alloc] initWithItemName:@"Backpack"];
        [items addObject:backpack];
        
        BNRItem *calculator = [[BNRItem alloc] initWithItemName:@"Calculator"];
        [items addObject:calculator];
        
        backpack.containedItem = calculator;
        
        backpack = nil;
        calculator = nil;
        for (BNRItem *item in items){
            NSLog(@"%@", item);
        }
        
        items = nil;
        
    }
    return 0;
}


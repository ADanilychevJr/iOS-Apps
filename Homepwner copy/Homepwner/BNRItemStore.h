//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Alex Danilychev, Jr. on 7/16/14.
//  Copyright (c) 2014 Alex Danilychev, Jr. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype) sharedStore;
- (BNRItem *) createItem;

@end

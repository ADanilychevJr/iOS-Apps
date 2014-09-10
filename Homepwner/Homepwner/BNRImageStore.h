//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Alex Danilychev, Jr. on 7/29/14.
//  Copyright (c) 2014 Alex Danilychev, Jr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject

+(instancetype) sharedStore;
-(void) setImage:(UIImage *) image forKey: (NSString *) key;
-(UIImage*)imageForKey: (NSString *) key;
-(void) deleteImageForKey: (NSString *) key;

@end

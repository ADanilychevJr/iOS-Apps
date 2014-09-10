//
//  BNRImageStore.m
//  Homepwner
//
//  Created by Alex Danilychev, Jr. on 7/29/14.
//  Copyright (c) 2014 Alex Danilychev, Jr. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore ()
@property (nonatomic, strong) NSMutableDictionary *dictionary;
@end
@implementation BNRImageStore

+(instancetype) sharedStore
{
    static BNRImageStore *sharedStore = nil;
    if (!sharedStore) {
        [[self alloc] initPrivate];
    }
    return sharedStore;
}

//No one else should call this init
-(instancetype) init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRItemStore sharedStore]" userInfo:nil];
    return nil;
}

-(instancetype) initPrivate
{
    self = [super init];
    if (self){
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void) setImage:(UIImage *)image forKey:(NSString *)key
{
    self.dictionary[key] = image;
}

-(UIImage *) imageForKey:(NSString *)key
{
    return self.dictionary[key];
}

-(void) deleteImageForKey:(NSString *)key
{
    [self.dictionary removeObjectForKey:key];
}
@end

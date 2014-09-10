//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Alex Danilychev, Jr. on 7/16/14.
//  Copyright (c) 2014 Alex Danilychev, Jr. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation BNRItemsViewController

-(instancetype) init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self){
        for (int i = 0; i < 5; i++){
            [[BNRItemStore sharedStore] createItem];
        }
        
    }
    return self;
}

-(instancetype) initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell" ];
    NSLog(@"%ld", (long)self.tableView.numberOfSections);
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    int total = items.count;
    int numLessThanFifty = 0;
    for (BNRItem *item in items){
        if (item.valueInDollars < 50){
            numLessThanFifty +=1;
        }
    }
    if (section == 0){
        return numLessThanFifty;
    } else {
        return total - numLessThanFifty;
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    NSMutableArray *cheapItems = [NSMutableArray new];
    NSMutableArray *expensiveItems = [NSMutableArray new];
    for (BNRItem *item in items){
        if (item.valueInDollars < 50){
            [cheapItems addObject:item ];
        } else {
            [expensiveItems addObject:item];
        }
    }
    BNRItem *item = nil;
    if (indexPath.section == 0){
        item = [cheapItems objectAtIndex: (indexPath.row % [cheapItems count])];
    } else {
        item = [expensiveItems objectAtIndex: (indexPath.row % [expensiveItems count])];
    }
    
    
    cell.textLabel.text = item.description;
    return cell;
}
@end

//
//  FriendListController.h
//  xplore
//
//  Created by Caroline Leung on 12-06-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendListController : UITableViewController

@property (nonatomic, strong) NSArray *friendsData;

- (id)initWithStyle:(UITableViewStyle)style friendsData:(NSArray*)friends;

@end

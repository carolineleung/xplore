//
//  FriendListCell.h
//  xplore
//
//  Created by Caroline Leung on 12-06-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

@interface FriendListCell : UITableViewCell

- (void)updateWithUser:(NSDictionary*)friend;

@end

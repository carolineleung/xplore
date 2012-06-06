//
//  FriendListCell.m
//  xplore
//
//  Created by Caroline Leung on 12-06-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FriendListCell.h"
#import "FBUser.h"

@implementation FriendListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:15.0f];
        self.textLabel.textColor = [UIColor darkGrayColor];
    }
    return self;
}

- (void)updateWithUser:(FBUser*)user {
    NSString *profileUrl = [user getSmallProfilePicUrl];
    [self.imageView setImageWithURL:[NSURL URLWithString:profileUrl] placeholderImage:[UIImage imageNamed:@"default_profile"]];        
    self.textLabel.text = user.name;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

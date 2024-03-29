//
//  UserProfileController.h
//  xplore
//
//  Created by Caroline Leung on 12-06-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

@interface UserProfileController : UIViewController <FBRequestDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView, *containerScrollView;
@property (nonatomic, strong) IBOutlet UILabel *name, *shortDesc, *location, *workHistoryTitleBar;
@property (nonatomic, strong) IBOutlet UIImageView *profileImage;
@property (nonatomic, unsafe_unretained) id<FBSessionDelegate> sessionDelegate;
@property (nonatomic, strong) IBOutlet UIButton *peopleButton;

@property (nonatomic, strong) NSMutableArray *friendsData;

- (IBAction)viewFriends:(id)sender;

@end

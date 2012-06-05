//
//  RootController.h
//  xplore
//
//  Created by Caroline Leung on 12-06-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface RootController : UIViewController <FBSessionDelegate>

@property (nonatomic, strong) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) IBOutlet UILabel *loggedInText;

- (IBAction)loginClicked:(id)sender;

@end

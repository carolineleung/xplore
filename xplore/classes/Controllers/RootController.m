//
//  RootController.m
//  xplore
//
//  Created by Caroline Leung on 12-06-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RootController.h"
#import "Utility.h"
#import "UserProfileController.h"

@interface RootController (private)

- (void)checkLogin;
- (void)alreadyLoggedIn;
- (void)notLogin;

@end

@implementation RootController

@synthesize loginButton = _loginButton, loggedInText = _loggedInText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self checkLogin];
}

#pragma mark - Private methods



- (void)checkLogin {
    Facebook *facebook = [Utility getFBInstance];
    if ([facebook isSessionValid]) {
        [self alreadyLoggedIn];
    } else {
        [self notLogin];
    }
}

- (void)alreadyLoggedIn {
    [self.navigationController setNavigationBarHidden:NO animated:NO];    
    self.loginButton.hidden = YES;
    self.loggedInText.hidden = NO;
    UserProfileController *userProfileController = [[UserProfileController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:userProfileController animated:YES];    
}

- (void)notLogin {
    [self.navigationController setNavigationBarHidden:YES animated:NO];    
    self.loginButton.hidden = NO;
    self.loggedInText.hidden = YES;
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

#pragma mark - UIButtonDelegate

- (void)loginClicked:(id)sender {
    NSArray *permissions = [NSArray arrayWithObjects:@"user_location", @"user_education_history", @"friends_education_history", @"user_work_history", @"friends_work_history", @"user_location", @"friends_location", @"user_about_me", nil];
    [[Utility getFBInstance] authorize:permissions];
}


#pragma mark - FBSessionDelegate 

- (void)storeFBAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

- (void)fbDidLogin {
    Facebook *facebook = [Utility getFBInstance];
    [self storeFBAuthData:[facebook accessToken] expiresAt:[facebook expirationDate]];
    [self alreadyLoggedIn];
}

- (void)fbDidNotLogin:(BOOL)cancelled {
    NSLog(@"fbDidNotLogin");
}

- (void)fbDidExtendToken:(NSString*)accessToken expiresAt:(NSDate*)expiresAt {
    NSLog(@"fbDidExtendToken %@, expires at: %@", accessToken, expiresAt);
    [self storeFBAuthData:accessToken expiresAt:expiresAt];
}


- (void)clearUserSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

- (void)fbDidLogout {
    NSLog(@"fbDidLogout");
    [self clearUserSettings];
}

- (void)fbSessionInvalidated {
    NSLog(@"fbSession invalidated");
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

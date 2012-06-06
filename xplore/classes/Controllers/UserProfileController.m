//
//  UserProfileController.m
//  xplore
//
//  Created by Caroline Leung on 12-06-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserProfileController.h"
#import "WorkHistoryView.h"
#import "FriendListController.h"
#import "FBUser.h"

#define yPadding 10.0f

@interface UserProfileController (private)

- (void)apiGraphMe;
- (fbApiType)urlToType:(NSString*)requestUrl;
- (void)handleGraphMeRequest:(FBRequest *)request didLoad:(id)result;
- (void)handleGraphFriendsRequest:(FBRequest *)request didLoad:(id)result;
- (void)apiGraphFriends;
@end


@implementation UserProfileController

@synthesize name = _name, location = _location, shortDesc = _shortDesc, profileImage = _profileImage, sessionDelegate = _sessionDelegate, workHistoryTitleBar = _workHistoryTitleBar, scrollView = _scrollView, containerScrollView = _containerScrollView, friendsData = _friendsData, peopleButton = _peopleButton;


- (id)initWithFBSessionDelegate:(id<FBSessionDelegate>)delegate {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.sessionDelegate = delegate;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.friendsData = [NSMutableArray array];
    
    self.navigationItem.title = @"Xplore";
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(logout:)];

    [self apiGraphMe];
    [self apiGraphFriends];
}

#pragma mark - Graph API requests

- (void)apiGraphMe {
    //TODO show loading
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"name, picture, work, education, location",  @"fields", nil];
    [[Utility getFBInstance] requestWithGraphPath:@"me" andParams:params andDelegate:self];
}

- (void)apiGraphFriends {
    //TODO show loading
    [[Utility getFBInstance] requestWithGraphPath:@"me/friends" andDelegate:self];
}

#pragma mark - Graph API response handling

- (void)handleGraphMeRequest:(FBRequest *)request didLoad:(id)result {
    NSString *username = [result objectForKey:@"name"];
    self.name.text = username ? username : @"(Unknown)";
    NSString *pictureUrl = [result objectForKey:@"picture"];
    if (pictureUrl) {
        [self.profileImage setImageWithURL:[NSURL URLWithString:pictureUrl] placeholderImage:[UIImage  imageNamed:@"default_profile"]];
    }
    NSDictionary *locationData = [result objectForKey:@"location"];
    if (locationData) {
        NSString *locationName = [locationData objectForKey:@"name"];
        self.location.text = locationName; 
    }
    
    CGFloat yOffset = _workHistoryTitleBar.frame.origin.y + _workHistoryTitleBar.frame.size.height;
    NSArray *workHistoryList = [result objectForKey:@"work"];
    if (workHistoryList.count) {
        for (NSDictionary *workData in workHistoryList) {
            WorkHistoryView *workHistoryView = [[WorkHistoryView alloc] initWithFrame:CGRectMake(_profileImage.frame.origin.x, yOffset + yPadding, self.view.frame.size.width - 2 * _profileImage.frame.origin.x, 200) data:workData];
            yOffset = workHistoryView.frame.origin.y + workHistoryView.frame.size.height;
            [self.containerScrollView addSubview:workHistoryView];
            
            // Use most recent job entry as short description
            if (!self.shortDesc.text.length) {
                NSString *positionText = workHistoryView.position.text;
                self.shortDesc.text = [NSString stringWithFormat:@"%@%@", positionText.length ? [NSString stringWithFormat:@"%@ at ", positionText] : @"",  workHistoryView.employerName.text];
            }            
        }
    }
    yOffset += 50;
    self.containerScrollView.contentSize = CGSizeMake(self.containerScrollView.frame.size.width, yOffset);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, yOffset + _containerScrollView.frame.origin.y);
    self.containerScrollView.scrollEnabled = NO;
}

- (void)handleGraphFriendsRequest:(FBRequest *)request didLoad:(id)result {
    NSArray *resultData = [result objectForKey:@"data"];
    for (NSDictionary *friendData in resultData) {
        FBUser *user = [[FBUser alloc] initWithUserData:friendData];
        [self.friendsData addObject:user];
    }
}


#pragma mark - Graph API response callback

- (void)request:(FBRequest *)request didLoad:(id)result {
    NSLog(@"Received response for %@ - %@", request.url, result);
    fbApiType apiType = [self urlToType:request.url];
    switch (apiType) {
        case kApiGraphMe:
            [self handleGraphMeRequest:request didLoad:result];
            break;
            
        case kApiGraphUserFriends:
            [self handleGraphFriendsRequest:request didLoad:result];
            break;
            
        default:
            NSLog(@"Unexpected graph api request %@, result: %@", request.url, result);
            break;
    }
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Received error: %@ for request: %@", error, request.url);
}

- (void)logout:(id)sender {
    [[Utility getFBInstance] logout:self.sessionDelegate];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Button clicked 

- (void)viewFriends:(id)sender {
    FriendListController *friendListController = [[FriendListController alloc] initWithStyle:UITableViewStylePlain friendsData:self.friendsData];
    [self.navigationController pushViewController:friendListController animated:YES];
}

#pragma mark - Private methods

- (fbApiType)urlToType:(NSString *)requestUrl {
    fbApiType type;
    if ([requestUrl isEqualToString:@"https://graph.facebook.com/me"]) {
        type = kApiGraphMe;
    } else if ([requestUrl isEqualToString:@"https://graph.facebook.com/me/friends"]) {
        type = kApiGraphUserFriends;
    }
    return type;
}

#pragma mark - View Lifecycle

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

//
//  UserProfileController.m
//  xplore
//
//  Created by Caroline Leung on 12-06-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserProfileController.h"
#import "WorkHistoryView.h"

#define yPadding 10.0f

@interface UserProfileController (private)

- (void)apiGraphMe;

@end


@implementation UserProfileController

@synthesize name = _name, location = _location, shortDesc = _shortDesc, profileImage = _profileImage, sessionDelegate = _sessionDelegate, workHistoryTitleBar = _workHistoryTitleBar, scrollView = _scrollView;

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
    [self.navigationController.navigationItem setBackBarButtonItem:nil];
    
    self.navigationItem.title = @"Xplore";
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(logout:)];

    [self apiGraphMe];
}

#pragma mark - Graph API

- (void)apiGraphMe {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"name, picture, work, education, location",  @"fields", nil];
    [[Utility getFBInstance] requestWithGraphPath:@"me" andParams:params andDelegate:self];
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    NSLog(@"Received %@", result);
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
            [self.scrollView addSubview:workHistoryView];

            // Use most recent job entry as short description
            if (!self.shortDesc.text.length) {
                NSString *positionText = workHistoryView.position.text;
                self.shortDesc.text = [NSString stringWithFormat:@"%@%@", positionText.length ? [NSString stringWithFormat:@"%@ at ", positionText] : @"",  workHistoryView.employerName.text];
            }            
        }
    }
    yOffset += 50;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, yOffset);
    
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Received error %@ for request %@", error, request);
}

- (void)logout:(id)sender {
    [[Utility getFBInstance] logout:self.sessionDelegate];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

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

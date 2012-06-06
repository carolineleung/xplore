//
//  FBUser.m
//  xplore
//
//  Created by Caroline Leung on 12-06-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FBUser.h"

@implementation FBUser

@synthesize userId = _userId, name = _name;

- (id)initWithUserData:(NSDictionary*)userData {
    self = [super init];
    if (self) {
        self.userId = [userData objectForKey:@"id"];
        self.name = [userData objectForKey:@"name"];                     
    }
    return self;
}

- (NSString*)getSmallProfilePicUrl {
    return [NSString stringWithFormat:kFBProfileUrlSmall, self.userId];
}

@end

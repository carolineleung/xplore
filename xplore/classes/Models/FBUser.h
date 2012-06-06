//
//  FBUser.h
//  xplore
//
//  Created by Caroline Leung on 12-06-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBUser : NSObject

@property (nonatomic, strong) NSString *userId, *name;

- (id)initWithUserData:(NSDictionary*)userData;
- (NSString*)getSmallProfilePicUrl;

@end

//
//  Utility.h
//  xplore
//
//  Created by Caroline Leung on 12-06-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XploreAppDelegate.h"

typedef enum fbApiType {
    kApiGraphMe,
    kApiGraphUserFriends
} fbApiType;


@interface Utility : NSObject

+ (BOOL)isDeviceiPad;
+ (BOOL)isDeviceiPhone;

+ (XploreAppDelegate*)getAppDelegate;
+ (Facebook*)getFBInstance;


@end

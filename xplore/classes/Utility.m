//
//  Utility.m
//  xplore
//
//  Created by Caroline Leung on 12-06-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (BOOL)isDeviceiPad {
	return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
} 

+ (BOOL)isDeviceiPhone {
	return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
} 

+ (XploreAppDelegate*)getAppDelegate {
    return (XploreAppDelegate*) [[UIApplication sharedApplication] delegate];
}

+ (Facebook *)getFBInstance {
    return [self getAppDelegate].facebook;
}

@end

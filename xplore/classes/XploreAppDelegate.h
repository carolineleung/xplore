//
//  AppDelegate.h
//  xplore
//
//  Created by Caroline Leung on 12-06-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "RootController.h"

@interface XploreAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) Facebook *facebook;

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) RootController *rootController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

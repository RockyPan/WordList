//
//  TWAppDelegate.m
//  WordList
//
//  Created by PanKyle on 14-7-27.
//  Copyright (c) 2014年 TGD. All rights reserved.
//

#import "TWAppDelegate.h"

#import <CoreData/CoreData.h>

@implementation TWAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSManagedObjectContext *) managedObjectContext
{
    if (nil == _managedObjectContext) {
        NSPersistentStoreCoordinator * coordinator = [self persistentStoreCoordinator];
        if (nil != coordinator) {
            _managedObjectContext = [[NSManagedObjectContext alloc] init];
            [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        }
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *) managedObjectModel
{
    if (nil == _managedObjectModel) {
        NSURL * modelURL = [[NSBundle mainBundle] URLForResource:@"words" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator
{
    if (nil == _persistentStoreCoordinator) {
        NSURL * storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"words.sqlite"];
        NSError * error = nil;
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                       configuration:nil
                                                                 URL:storeURL
                                                             options:nil
                                                               error:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    return _persistentStoreCoordinator;
}

- (void) saveContext
{
    NSError * error = nil;
    NSManagedObjectContext * managedObjectContext = self.managedObjectContext;
    if (nil != managedObjectContext) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSArray *)studyList {
    NSMutableArray * res = [[NSMutableArray alloc] init];
    if ([self.wordsObj count] < 20) {
        for (NSManagedObject * value in self.wordsObj) {
            [res addObject:value];
        }
    } else {
        NSMutableArray * pool = [self.wordsObj copy];
        for (int i = 0; i < 20; ++i) {
            int span = [pool count] * ([pool count] + 1) / 2;
            int idx = arc4random() % span + 1;
            idx = sqrt(idx * 2);
            idx = [pool count] - idx;
            [res addObject:pool[idx]];
            [pool removeObjectAtIndex:idx];
        }
    }
    return res;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Words" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    NSMutableArray * sorts = [[NSMutableArray alloc] init];
    [sorts addObject:[[NSSortDescriptor alloc] initWithKey:@"familiarity" ascending:NO]];
    [sorts addObject:[[NSSortDescriptor alloc] initWithKey:@"lastAccess" ascending:NO]];
    [request setSortDescriptors:sorts];
    NSError * error = nil;
    self.wordsObj = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

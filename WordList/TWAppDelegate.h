//
//  TWAppDelegate.h
//  WordList
//
//  Created by PanKyle on 14-7-27.
//  Copyright (c) 2014年 TGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext * managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel * managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator * persistentStoreCoordinator;

//@property (nonatomic, strong) NSMutableArray * wordsList;
@property (nonatomic, strong) NSMutableArray * wordsObj;

- (void) saveContext;

@end

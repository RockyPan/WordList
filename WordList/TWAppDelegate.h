//
//  TWAppDelegate.h
//  WordList
//
//  Created by PanKyle on 14-7-27.
//  Copyright (c) 2014年 TGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface TWAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext * managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel * managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator * persistentStoreCoordinator;

@property (nonatomic, strong) NSMutableArray * wordsObj;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)loadWords;

/**
 *  从单词对象数组中随机抽取20个单词，排序越前权重越大。
 *
 *  @return 数组元素为NSManageObject，为单词表的行对象
 */
- (NSMutableArray *) studyList;

/**
 *  对单词对象数组进行排序，首先按熟悉程度由低到高，再按时间由远到近。
 */
- (void)sortWords;

/**
 *  从单词对象数组中得到一个随机的单词对象
 *
 *  @return 单词对象
 */
- (NSManagedObject *)randomWord;

@end

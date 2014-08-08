//
//  TWSetupVC.m
//  WordList
//
//  Created by PanKyle on 14-8-5.
//  Copyright (c) 2014年 TGD. All rights reserved.
//

#import "TWSetupVC.h"
#import "TWAppDelegate.h"

@interface TWSetupVC ()

@property (nonatomic, weak) TWAppDelegate * appDelegate;

@end

@implementation TWSetupVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.appDelegate = (TWAppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger displayType = [defaults integerForKey:@"displayType"];
    self.displayType.selectedSegmentIndex = displayType;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)displayTypeChange:(id)sender {
    NSInteger displayType = self.displayType.selectedSegmentIndex;
    [[NSUserDefaults standardUserDefaults] setInteger:displayType forKey:@"displayType"];
}

- (IBAction)export2File:(id)sender {
    NSMutableArray * export = [[NSMutableArray alloc] init];
    for (NSManagedObject * value in self.appDelegate.wordsObj) {
        NSDictionary * word = [NSDictionary dictionaryWithObjectsAndKeys:
                               [value valueForKey:@"word"], @"word",
                               [value valueForKey:@"meaning"], @"meaning",
                               [value valueForKey:@"familiarity"], @"familiarity",
                               [value valueForKey:@"lastAccess"], @"lastAccess",
                               nil];
        [export addObject:word];
    }
    BOOL res = [export writeToURL:[[self.appDelegate applicationDocumentsDirectory] URLByAppendingPathComponent:@"words.txt"] atomically:YES];
    NSString * prompt = nil;
    if (res) prompt = @"导出数据成功！";
    else prompt = @"导出数据失败！";
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:prompt delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (IBAction)importFromFile:(id)sender {
    NSManagedObjectContext * context = self.appDelegate.managedObjectContext;
    NSLog(@"已有的%ld个条目。", [self.appDelegate.wordsObj count]);
    
    NSArray * import = [[NSArray alloc] initWithContentsOfURL:[[self.appDelegate applicationDocumentsDirectory] URLByAppendingPathComponent:@"words.txt"]];
    NSLog(@"导入%ld个条目。", [import count]);
    
    for (NSManagedObject * value in self.appDelegate.wordsObj) {
        [context deleteObject:value];
    }
    for (NSDictionary * value in import) {
        NSManagedObject * obj = [NSEntityDescription insertNewObjectForEntityForName:@"Words" inManagedObjectContext:context];
        [obj setValue:value[@"word"] forKey:@"word"];
        [obj setValue:value[@"meaning"] forKey:@"meaning"];
        [obj setValue:value[@"familiarity"] forKey:@"familiarity"];
        [obj setValue:value[@"lastAccess"] forKey:@"lastAccess"];
    }
    [self.appDelegate saveContext];
    
    [self.appDelegate.wordsObj removeAllObjects];
    [self.appDelegate loadWords];
}

@end

//
//  TWStudyVC.m
//  WordList
//
//  Created by PanKyle on 14-7-28.
//  Copyright (c) 2014年 TGD. All rights reserved.
//

#import "TWStudyVC.h"
#import "TWAppDelegate.h"

#import <CoreData/CoreData.h>

@interface TWStudyVC ()

@property (nonatomic, strong) NSMutableArray * words;
@property (nonatomic, weak) TWAppDelegate * appDelegate;

@end

@implementation TWStudyVC

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
    self.words = [self.appDelegate studyList];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.words count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row < [self.words count]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"wordQuiz"];
        NSString * str = [NSString stringWithFormat:@"%@\n%@", [self.words[indexPath.row] valueForKey:@"word"], [self.words[indexPath.row] valueForKey:@"meaning"]];
        UILabel * label = (UILabel *)[cell viewWithTag:101];
        label.text = str;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"button"];
    }
    
#ifdef DEBUG
//    NSLog(@"Cell recursive description:\n\n%@\n\n", [cell performSelector:@selector(recursiveDescription)]);
#endif
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)reloadWordList:(id)sender {
    self.words = [self.appDelegate studyList];
    [self.tableView reloadData];
}

- (IBAction)wrong:(UIButton *)sender {
    [self processButton:sender withOffset:-1];
}

- (IBAction)right:(UIButton *)sender {
    [self processButton:sender withOffset:1];
}

- (void)processButton:(UIButton *)button withOffset:(int)offset {
    UITableViewCell * cell = (UITableViewCell *)[[[button superview] superview] superview];
    NSInteger idx = [self.tableView indexPathForCell:cell].row;
    NSManagedObject * obj = self.words[idx];
    [self updateWord:obj familarity:offset];
    [self.words removeObjectAtIndex:idx];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)updateWord:(NSManagedObject *)obj familarity:(int)offset {
    int f = ((NSNumber *)[obj valueForKey:@"familiarity"]).intValue;
    f += offset;
    [obj setValue:[NSNumber numberWithInt:f] forKey:@"familiarity"];
    [self.appDelegate saveContext];
}

@end

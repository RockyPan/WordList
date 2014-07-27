//
//  TWAddWordVC.m
//  WordList
//
//  Created by PanKyle on 14-7-27.
//  Copyright (c) 2014年 TGD. All rights reserved.
//

#import "TWAddWordVC.h"
#import "TWAppDelegate.h"

#import <CoreData/CoreData.h>

@interface TWAddWordVC ()

@property (nonatomic, strong) NSArray * words;
@property (nonatomic, strong) NSString * word;
@property (nonatomic, strong) NSString * meaning;

@end

@implementation TWAddWordVC



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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getWordInfo:(NSManagedObject *)word {
    NSString * res = nil;
    return res;
}

- (void)textFieldWithText:(UITextField *)textField
{
    if (0 == textField.tag) {
        self.word = textField.text;
    }
    if (1 == textField.tag) {
        self.meaning = textField.text;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) return 3;
    if (1 == section) return [self.words count];
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = nil;
    if (0 == indexPath.section) {
        if (0 == indexPath.row || 1 == indexPath.row) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"wordCell"];
            UITextField * text = (UITextField *)[cell viewWithTag:100];
            if (nil != text) [text setTag:indexPath.row];
            [text addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
            if (0 == indexPath.row) {
                text.placeholder = @"输入单词";
            }
            if (1 == indexPath.row) {
                text.placeholder = @"输入词义";
            }
        }
        if (2 == indexPath.row) cell = [tableView dequeueReusableCellWithIdentifier:@"buttonCell"];
    }
    if (1 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"wordListCell"];
        cell.textLabel.text = [self getWordInfo:self.words[indexPath.row]];
    }
    
    // Configure the cell...
    
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

- (IBAction)addWord:(id)sender {
    NSLog(@"%@:%@", self.word, self.meaning);
    
    NSString * prompt = nil;
    BOOL valid = TRUE;
    if (0 == [self.word length] || 0 == [self.meaning]) {
        valid = FALSE;
        prompt = @"单词和词义都不能为空。";
        UIAlertView
    }
    //检查单词是否重复了
    
    //保存单词
    
    //清空
    self.word = @"";
    self.meaning = @"";
    //清空textfield内容
}
@end

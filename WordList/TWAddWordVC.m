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

@property (nonatomic, strong) NSArray * filterWords;
@property (nonatomic, strong) NSString * word;
@property (nonatomic, strong) NSString * meaning;

@property (nonatomic, weak) TWAppDelegate * appDelegate;

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
    self.appDelegate = (TWAppDelegate *)[UIApplication sharedApplication].delegate;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getWordInfo:(NSManagedObject *)word {
    NSString * res = nil;
    NSString * sw = [word valueForKey:@"word"];
    NSString * sm = [word valueForKey:@"meaning"];
    res = [NSString stringWithFormat:@"%@\n%@", sw, sm];
    return res;
}

- (void)textFieldWithText:(UITextField *)textField
{
    if (1 == textField.tag) {
        self.word = textField.text;
        
        NSPredicate * pre = [NSPredicate predicateWithFormat:@"word beginsWith %@", self.word];
        self.filterWords = [self.appDelegate.wordsObj filteredArrayUsingPredicate:pre];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        [textField becomeFirstResponder];
    }
    
    if (2 == textField.tag) {
        self.meaning = textField.text;
    }
}

- (void)hideKeyboard {
    [self.view endEditing:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) return 3;
    if (1 == section) return [self.filterWords count];
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = nil;
    if (0 == indexPath.section) {
        if (0 == indexPath.row || 1 == indexPath.row) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"wordCell"];
            UITextField * text = (UITextField *)[cell viewWithTag:100];
            if (nil != text) {
                [text setTag:indexPath.row + 1];
                [text addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
            }
            if (0 == indexPath.row) {
                if (0 == [self.word length]) {
                    text.text = @"";
                    text.placeholder = @"输入单词";
                } else {
                    text.text = self.word;
                }
            }
            if (1 == indexPath.row) {
                if (0 == [self.meaning length]) {
                    text.text = @"";
                    text.placeholder = @"输入词义";
                } else {
                    text.text = self.meaning;
                }
            }
        }
        if (2 == indexPath.row) cell = [tableView dequeueReusableCellWithIdentifier:@"buttonCell"];
    }
    if (1 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"wordListCell"];
        UILabel * label = (UILabel *) [cell viewWithTag:101];
        label.text = [self getWordInfo:self.filterWords[indexPath.row]];
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
    
    if (0 == [self.word length] || 0 == [self.meaning length]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"数据有误" message:@"单词和词义都不能为空。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    //检查单词是否重复了
    NSPredicate * pre = [NSPredicate predicateWithFormat:@"word == %@", self.word];
    NSArray * matchs = [self.appDelegate.wordsObj filteredArrayUsingPredicate:pre];
    if (0 != [matchs count]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"数据有误" message:@"该单词已经存在。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    //保存单词
    NSManagedObjectContext * context = self.appDelegate.managedObjectContext;
    NSManagedObject * obj = [NSEntityDescription insertNewObjectForEntityForName:@"Words" inManagedObjectContext:context];
    [obj setValue:self.word forKey:@"word"];
    [obj setValue:self.meaning forKey:@"meaning"];
    [self.appDelegate saveContext];
    [self.appDelegate.wordsObj addObject:obj];
    //[self.appDelegate.wordsList addObject:self.word];
    
    //清空
    self.word = @"";
    self.meaning = @"";
    //清空textfield内容
    UITableViewCell * cellW = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField * textW = (UITextField *)[cellW viewWithTag:1];
    textW.text = @"";
    UITableViewCell * cellM = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITextField * textM = (UITextField *)[cellM viewWithTag:2];
    textM.text = @"";
    [textW becomeFirstResponder];
    
    
    //[self.tableView reloadSections:0 withRowAnimation:UITableViewRowAnimationNone];
}
@end

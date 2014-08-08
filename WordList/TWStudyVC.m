//
//  TWStudyVC.m
//  WordList
//
//  Created by PanKyle on 14-8-5.
//  Copyright (c) 2014年 TGD. All rights reserved.
//

#import "TWStudyVC.h"
#import "TWAppDelegate.h"

@interface TWStudyVC ()

@property (nonatomic, weak) TWAppDelegate * appDelegate;
@property (nonatomic, strong) NSManagedObject * curWordObj;

@end

BOOL isWord;

@implementation TWStudyVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.appDelegate = (TWAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self displayWord];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)updateWord:(int)offset {
    NSNumber * familiarity = [self.curWordObj valueForKey:@"familiarity"];
    familiarity = [NSNumber numberWithInt:familiarity.intValue + offset];
    [self.curWordObj setValue:familiarity forKey:@"familiarity"];
    [self.curWordObj setValue:[NSDate date] forKey:@"lastAccess"];
    [self.appDelegate saveContext];
}

- (IBAction)wrong:(id)sender {
    [self updateWord:-1];
    [self.appDelegate sortWords];
    [self displayWord];
}

- (IBAction)right:(id)sender {
    [self updateWord:1];
    [self.appDelegate sortWords];
    [self displayWord];
}

- (IBAction)check:(id)sender {
    if (isWord) {
        NSString * meaning = [self.curWordObj valueForKey:@"meaning"];
        self.textMeaning.text = meaning;
    } else {
        NSString * word = [self.curWordObj valueForKey:@"word"];
        self.textWord.text = word;
    }
}

- (void) displayWord {
    NSManagedObject * wordObj = [self.appDelegate randomWord];
    if (nil == wordObj) return;
    for ( ; wordObj == self.curWordObj;  ) {
        wordObj = [self.appDelegate randomWord];
    }
    self.curWordObj = wordObj;
    
    isWord = arc4random() % 2 == 0;
    NSString * word = @"";
    NSString * meaning = @"";
    if (isWord) word = [wordObj valueForKey:@"word"];
    else meaning = [wordObj valueForKey:@"meaning"];
    self.textWord.text = word;
    self.textMeaning.text = meaning;
}

@end

//
//  TWSetupVC.m
//  WordList
//
//  Created by PanKyle on 14-8-5.
//  Copyright (c) 2014年 TGD. All rights reserved.
//

#import "TWSetupVC.h"

@interface TWSetupVC ()

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
@end

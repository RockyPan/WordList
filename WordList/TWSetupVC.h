//
//  TWSetupVC.h
//  WordList
//
//  Created by PanKyle on 14-8-5.
//  Copyright (c) 2014年 TGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWSetupVC : UITableViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *displayType;
- (IBAction)displayTypeChange:(id)sender;

@end

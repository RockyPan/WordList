//
//  TWStudyVC.h
//  WordList
//
//  Created by PanKyle on 14-7-28.
//  Copyright (c) 2014年 TGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWReciteVC : UITableViewController

- (IBAction)reloadWordList:(id)sender;
- (IBAction)wrong:(UIButton *)sender;
- (IBAction)right:(UIButton *)sender;

@end

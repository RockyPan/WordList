//
//  TWStudyVC.h
//  WordList
//
//  Created by PanKyle on 14-8-5.
//  Copyright (c) 2014年 TGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWStudyVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *textWord;
@property (weak, nonatomic) IBOutlet UILabel *textMeaning;

- (IBAction)wrong:(id)sender;
- (IBAction)right:(id)sender;
- (IBAction)check:(id)sender;

@end

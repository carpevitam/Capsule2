//
//  TextViewController.h
//  Capsule
//
//  Created by Sneha Sankavaram on 10/4/14.
//  Copyright (c) 2014 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewController : UIViewController <UITextViewDelegate>
- (IBAction)doneEditing:(id)sender;
- (IBAction)saveText:(id)sender;
- (IBAction)cancelText:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end

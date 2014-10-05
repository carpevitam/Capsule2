//
//  FriendsListViewController.h
//  Capsule
//
//  Created by Andy Li on 10/5/14.
//  Copyright (c) 2014 Mask. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>

@interface FriendsListViewController : FBFriendPickerViewController <FBFriendPickerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *createButton;
- (IBAction)createCapsule:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *capsuleName;
@end

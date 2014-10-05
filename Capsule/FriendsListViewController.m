//
//  FriendsListViewController.m
//  Capsule
//
//  Created by Andy Li on 10/5/14.
//  Copyright (c) 2014 Mask. All rights reserved.
//

#import "FriendsListViewController.h"
#import <Parse/Parse.h>

@interface FriendsListViewController ()

@end

@implementation FriendsListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"isopen: %d ", [[FBSession activeSession] isOpen]);
    self.delegate = self;
    [self loadData];
    self.doneButton = nil;
    self.cancelButton = nil;
    self.allowsMultipleSelection = YES;
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

- (IBAction)createCapsule:(id)sender {
    PFObject *capsule = [PFObject objectWithClassName:@"Capsule"];
    capsule[@"Name"] = self.capsuleName.text;
    capsule[@"Users"] = self.selection;

    capsule[@"Owner"] = [PFUser currentUser].objectId;
    [capsule saveInBackground];
    
    PFUser *me = [PFUser currentUser];
    if (me[@"Capsules"] == nil){
        me[@"capsules"] = [[NSMutableArray alloc]init];
    }
    [me[@"Capsules"] addObject:capsule];
    [me saveInBackground];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma Text Field Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
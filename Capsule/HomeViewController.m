//
//  HomeViewController.m
//  Capsule
//
//  Created by Maya Reddy on 10/4/14.
//  Copyright (c) 2014 Mask. All rights reserved.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "ViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    // Do any additional setup after loading the view.
    if ([PFUser currentUser])
        NSLog(@"%@",[PFUser currentUser]);
    else{
        //self.modalTransitionStyle =
//UIViewController *login = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
        //ViewController *login = [[ViewController alloc]init];
        //login.delegate = self;
        ViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"logIn"];
        [self presentViewController:login animated:YES completion:^{ }];
        //ViewController2 *myVC2 = [[ViewController2 alloc] initWithNibName:@"ViewController2" bundle:nil];

    }
    
        NSLog(@"Login");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) logout{
    [[PFFacebookUtils session]closeAndClearTokenInformation];
    [PFUser logOut];
    ViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"logIn"];
    [self presentViewController:login animated:YES completion:^{ }];
    
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

@end

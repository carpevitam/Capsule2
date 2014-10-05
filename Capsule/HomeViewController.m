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
#import "CapsuleCell.h"
#import "CapsuleController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    NSLog(@"SELFSELFSEFL");
    if (self) {
        _capsules = [PFUser currentUser][@"Capsules"];
        NSLog(@"\nUSER:%@\ncapsules%@",[PFUser currentUser],[PFUser currentUser][@"Capsules"]);
        //
        // TEMP TEMP
        if (_capsules.count == 0) {
            ;//_capsules = [[NSMutableArray alloc] initWithArray:@[@"wat"]];
        }
        for (int i = 0; i < [_capsules count]; i++){
            NSString *capsuleIds = _capsules[i][@"objectId"];
            NSLog(@"NSLOGHERE:%@",capsuleIds);
            
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _capsules = [PFUser currentUser][@"Capsules"];
    NSLog(@"%d",_capsules.count);
    if (_capsules.count == 0) {
        _capsules = [[NSMutableArray alloc] initWithArray:@[@"wat"]];
    }
    
    
    //NSLog(@"\nUSER:%@\ncapsules%@",[PFUser currentUser],[PFUser currentUser][@"Capsules"]);
    NSLog(@"%@",_capsules[0]);
    //
    // TEMP TEMP
    for (int i = 0; i < [_capsules count]; i++){
        NSLog(@"%@",_capsules[i]);
    }

    _capsules = [[NSMutableArray alloc] initWithArray:@[@"wat"]];
    
    
    
    if ([PFUser currentUser])
        ;//NSLog(@"%@",[PFUser currentUser]);
    else{
        //self.modalTransitionStyle =
//UIViewController *login = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
        //ViewController *login = [[ViewController alloc]init];
        //login.delegate = self;
        ViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"logIn"];
        [self presentViewController:login animated:YES completion:^{ }];
        //ViewController2 *myVC2 = [[ViewController2 alloc] initWithNibName:@"ViewController2" bundle:nil];

    }
    
        //NSLog(@"Login");
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *segueName = segue.identifier;
    if ([segueName isEqualToString:@"HomeToCapsule"]) {
        CapsuleController *dest = (CapsuleController *)[segue destinationViewController];
        NSInteger index = [self.capsuleTable indexPathForSelectedRow].row;
        [dest setTitle: self.capsules[index]];
    }

}


#pragma TableView Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.capsules.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CapsuleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CapsuleCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[CapsuleCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CapsuleCell"];
    }
    cell.captionLabel.text = self.capsules[indexPath.row];
    return cell;
}


@end

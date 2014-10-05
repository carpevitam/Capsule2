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
#import "Capsule.h"
#import "CapsuleStore.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
//? Needed?
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    CapsuleStore *cs = [[CapsuleStore alloc] initWithCurrentUser];
    
    if ([PFUser currentUser])
        ;
    else {
        //self.modalTransitionStyle =
        ViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"logIn"];
        [self presentViewController:login animated:YES completion:^{}];

    }
    [nc addObserver:self selector:@selector(loadDataAfterCapsulesLoad) name:@"LoadedCapsules" object:nil];
}

- (void) loadDataAfterCapsulesLoad {
    [self.capsuleTable reloadData];
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
        if (!self.capsuleList) {
            self.capsuleList = [CapsuleStore sharedStore].capsuleList;
        }
        Capsule *c = self.capsuleList[index];
        [CapsuleStore sharedStore].currentCapsule = c;
        [dest setTitle:c.capsuleName];
    }

}


#pragma TableView Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [CapsuleStore sharedStore].capsuleList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.capsuleList) {
        self.capsuleList = [CapsuleStore sharedStore].capsuleList;
    }
    CapsuleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CapsuleCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[CapsuleCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CapsuleCell"];
    }
    Capsule *curr = self.capsuleList[indexPath.row];
    cell.titleLabel.text = curr.capsuleName;
    
    if (curr.image1) {
        cell.mainPicture.image = curr.image1;
    }
    if (curr.image2) {
        cell.smallPicture.image = curr.image2;
    }
    if (curr.text1) {
        cell.captionLabel.text = curr.text1;
    }

    return cell;
}


@end

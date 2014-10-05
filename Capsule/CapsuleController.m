//
//  CapsuleController.m
//  Capsule
//
//  Created by Sneha Sankavaram on 10/4/14.
//  Copyright (c) 2014 Mask. All rights reserved.
//

#import "CapsuleController.h"
#import "Capsule.h"
#import "CapsuleStore.h"
#import "ImageMomentCell.h"
#import "TextMomentCell.h"

@interface CapsuleController ()

@end

@implementation CapsuleController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePicture {
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:picker
                       animated:YES completion:NULL];
}

- (IBAction)choosePicture {
    picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker animated:YES completion:NULL];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    Capsule *capsuleInstance = [CapsuleStore sharedStore].currentCapsule;
    image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [capsuleInstance saveImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
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

#pragma Table View Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.moments) {
        self.moments = [CapsuleStore sharedStore].currentCapsule.moments;
    }
    id m = self.moments[indexPath.row];
    if ([m isMemberOfClass:[UIImage class]]) {
        ImageMomentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageMomentCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[ImageMomentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ImageMomentCell"];
        }
        cell.imageMoment.image = (UIImage *) m;
        return cell;
    } else {
        TextMomentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextMomentCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[TextMomentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TextMomentCell"];
        }
        cell.textMomentLabel.text = (NSString *) m;
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.moments) {
        self.moments = [CapsuleStore sharedStore].currentCapsule.moments;
    }
    NSLog(@"mommynts %lu", (unsigned long)self.moments.count);
    
    return self.moments.count;
}

@end

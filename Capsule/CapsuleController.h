//
//  CapsuleController.h
//  Capsule
//
//  Created by Sneha Sankavaram on 10/4/14.
//  Copyright (c) 2014 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CapsuleController : UIViewController <UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate>{
    
    UIImagePickerController *picker;
    UIImage *image;
}

@property (weak, nonatomic) IBOutlet UITableView *momentTable;
@property (strong, nonatomic) NSArray *moments;
- (IBAction) takePicture;
- (IBAction) choosePicture;

@end

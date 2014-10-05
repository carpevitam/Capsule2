//
//  CapsuleCell.h
//  Capsule
//
//  Created by Maya Reddy on 10/4/14.
//  Copyright (c) 2014 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CapsuleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainPicture;
@property (weak, nonatomic) IBOutlet UIImageView *smallPicture;

@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@end

//
//  Capsule.h
//  Capsule
//
//  Created by Sneha Sankavaram on 10/4/14.
//  Copyright (c) 2014 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Capsule : NSObject

@property NSString *capsuleName;
@property NSMutableArray *moments;
@property NSMutableArray *users;
@property PFObject *capsule;
@property UIImage *image1;
@property UIImage *image2;
@property NSString *text1;

- (instancetype) initWithPFObject:(PFObject*) obj;
- (NSString *) getFirstText;
- (UIImage *) getNthImage: (int) n;
- (void) saveText: (NSString *)text;
- (void) saveImage: (UIImage *)img;
@end

//
//  Capsule.m
//  Capsule
//
//  Created by Sneha Sankavaram on 10/4/14.
//  Copyright (c) 2014 Mask. All rights reserved.
//

#import "Capsule.h"

@implementation Capsule

- (instancetype) initWithPFObject:(PFObject*) obj {
    self = [super init];
    if (self) {
        _capsule = obj;
        _moments = [[NSMutableArray alloc] init];
        if (obj[@"Moments"]) {
            NSArray *arr = obj[@"Moments"];
            for (NSString *s in arr) {
                PFQuery *query = [PFQuery queryWithClassName:@"Moments"];
                PFObject *o = [query getObjectWithId:s];
                [_moments addObject:o];
            }
        }
        
        if (obj[@"Users"]) {
            _users = [[NSMutableArray alloc] initWithArray:((NSArray *)obj[@"Users"])];
        } else {
            _users = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

/* returns nil if no text */
- (NSString *)getFirstText {
    for (id mom in self.moments) {
        if ([((NSString *)mom[@"Type"]) isEqualToString:@"Text"]) {
            return mom[@"Text"];
        }
    }
    return  nil;
}

- (UIImage *) getNthImage:(int)n {
    int index = 0;
    for (id m in self.moments) {
        if ([((NSString *)m[@"Type"]) isEqualToString:@"ImageFile"]) {
            if (index == n) {
                PFFile *theImage = m[@"ImageFile"];
                UIImage __block *img;
                [theImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
                    img = [UIImage imageWithData:data];
                }];
                return img;
            }
            index++;
        }
    }
    return  nil;
}

- (void)saveImage:(UIImage *)img {
    PFObject *moment = [PFObject objectWithClassName:@"Moment"];
    moment[@"Type"] = @"ImageFile";
    
    NSData *imageData = UIImageJPEGRepresentation(img, 0.05f);
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
    // Save PFFile
    [imageFile saveInBackground];
    [moment setObject:imageFile forKey:@"ImageFile"];
    
    [moment saveInBackground];
    [self.capsule[@"Moments"] addObject:moment.objectId];
    [self.moments addObject:moment];

}

- (void) saveText:(NSString *)text {
    PFObject *moment = [PFObject objectWithClassName:@"Moment"];
    moment[@"Type"] = @"Text";
    moment[@"Text"] = text;
    [moment saveInBackground];
    [self.capsule[@"Moments"] addObject:moment.objectId];
    [self.moments addObject:moment];
}



@end

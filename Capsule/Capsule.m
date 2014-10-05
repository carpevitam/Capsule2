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
        _capsuleName = obj[@"Name"];
        _capsule = obj;
        _moments = [[NSMutableArray alloc] init];
        if (obj[@"Moments"]) {
            NSArray *arr = obj[@"Moments"];
            for (NSString *s in arr) {
                PFQuery *query = [PFQuery queryWithClassName:@"Moments"];
                PFObject *m = [query getObjectWithId:s];
                if ([((NSString *) m[@"Type"]) isEqualToString:@"Text"]) {
                    NSString *txt = [self getText:m];
                    [_moments addObject:txt];
                    if (!_text1) {
                        _text1 = txt;
                    }
                } else if ([((NSString *) m[@"Type"]) isEqualToString:@"ImageFile"]) {
                    UIImage *img = [self getImage:m];
                    [_moments addObject:img];
                    if (!_image1) {
                        _image1 = img;
                    } else if (!_image2) {
                        _image2 = img;
                    }
                }
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

- (NSString *) getText: (PFObject*) m{
    return m[@"Text"];
}

- (UIImage *) getImage: (PFObject*) m {
    PFFile *theImage = m[@"ImageFile"];
    UIImage __block *img;
    [theImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
        img = [UIImage imageWithData:data];
    }];
    return img;

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
    NSLog(@"moment %@", moment);
    
    if (!img) {
        return;
    }
    NSLog(@"waaaaaaaaaat");
    NSData *imageData = UIImageJPEGRepresentation(img, 0.05f);
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    NSLog(@"imageFaile %@", imageFile);
    
    // Save PFFile
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"booliano %d", succeeded);
    }];
    [moment setObject:imageFile forKey:@"ImageFile"];
    
    [moment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"bool %d", succeeded);
        if (!self.capsule[@"Moments"])
            self.capsule[@"Moments"] = [[NSMutableArray alloc]init];
        [self.capsule[@"Moments"] addObject:moment.objectId];
        [self.capsule saveInBackground];
        [self.moments addObject:moment];
    }];
}

- (void) saveText:(NSString *)text {
    PFObject *moment = [PFObject objectWithClassName:@"Moment"];
    moment[@"Type"] = @"Text";
    moment[@"Text"] = text;
    [moment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!self.capsule[@"Moments"])
            self.capsule[@"Moments"] = [[NSMutableArray alloc]init];
        [self.capsule[@"Moments"] addObject:moment.objectId];
        [self.capsule saveInBackground];
        [self.moments addObject:moment];
    }];
}



@end

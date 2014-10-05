//
//  CapsuleStore.m
//  Capsule
//
//  Created by Sneha Sankavaram on 10/4/14.
//  Copyright (c) 2014 Mask. All rights reserved.
//
#import <Parse/Parse.h>

#import "CapsuleStore.h"
#import "Capsule.h"

@implementation CapsuleStore
+ (instancetype) sharedStore {
    static CapsuleStore *shared;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        shared = [[self alloc] initPrivate];
    });
    return shared;
}


- (instancetype)init
{
    [NSException raise:@"Singleton" format:@"Use [CapsuleStore sharedStore]"];
    return nil;
}

- (instancetype)initWithCapsuleListObject:(PFObject*) obj
{
    self = [super init];
    if (self) {
        _capsuleList = [[NSMutableArray alloc] init];
        if (obj[@"Capsules"]) {
            PFQuery *query = [PFQuery queryWithClassName:@"Capsule"];
            NSString *objId = [PFUser currentUser].objectId;
            [query whereKey:@"objectId" equalTo:objId];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                for (PFObject *p in objects) {
                    Capsule *c = [[Capsule alloc] initWithPFObject:p];
                    [_capsuleList addObject:c];
                }
            }];
        }
    }
    return self;
    
}

/*
 * Only to be used inside this class to initialize singleton
 */
- (instancetype) initPrivate {
    self = [super init];
    if (self) {
        _capsuleList = [[NSMutableArray alloc] init];
    }
    return self;
}
@end

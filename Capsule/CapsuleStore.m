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

static CapsuleStore *store;

+ (instancetype) sharedStore {
    return store;
}


- (instancetype)init
{
    [NSException raise:@"Singleton" format:@"Use [CapsuleStore sharedStore]"];
    return nil;
}

- (instancetype)initWithCurrentUser
{
    self = [super init];
    if (self) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        PFUser *user = [PFUser currentUser];
        _capsuleList = [[NSMutableArray alloc] init];
        if (user[@"Capsules"]) {
            NSLog(@"has capsules");
            PFQuery *query = [PFQuery queryWithClassName:@"Capsule"];
            NSString *objId = [PFUser currentUser].objectId;
            [query whereKey:@"Owner" equalTo:objId];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                for (PFObject *p in objects) {
                    Capsule *c = [[Capsule alloc] initWithPFObject:p];
                    NSLog(@"caps %@", c);
                    [_capsuleList addObject:c];
                }
                NSLog(@"capsule length after loading %lu", (unsigned long)_capsuleList.count);
                [nc postNotificationName:@"LoadedCapsules" object:nil];
            }];
        }
    }
    [CapsuleStore permanentList:self];
    return self;
}

+ (void) permanentList:(CapsuleStore *) cap {
    store = cap;
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

- (void) refreshData {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    PFUser *user = [PFUser currentUser];
    _capsuleList = [[NSMutableArray alloc] init];
    if (user[@"Capsules"]) {
        NSLog(@"has capsules");
        PFQuery *query = [PFQuery queryWithClassName:@"Capsule"];
        NSString *objId = [PFUser currentUser].objectId;
        [query whereKey:@"Owner" equalTo:objId];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            NSLog(@"objects %@", objects);
            for (PFObject *p in objects) {
                Capsule *c = [[Capsule alloc] initWithPFObject:p];
                [_capsuleList addObject:c];
            }
            NSLog(@"capsule length after loading %lu", (unsigned long)_capsuleList.count);
            [nc postNotificationName:@"LoadedCapsules" object:nil];
        }];
    }
}
@end

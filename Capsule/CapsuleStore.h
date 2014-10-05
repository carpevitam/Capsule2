//
//  CapsuleStore.h
//  Capsule
//
//  Created by Sneha Sankavaram on 10/4/14.
//  Copyright (c) 2014 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Capsule;

@interface CapsuleStore : NSObject

@property NSMutableArray *capsuleList;
@property Capsule *currentCapsule;

- (instancetype)initWithCapsuleListObject:(PFObject*) obj;

@end

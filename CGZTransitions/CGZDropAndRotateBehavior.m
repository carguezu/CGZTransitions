//
//  CGZDropAndRotateBehavior.m
//
//  Created by Carlos on 13/03/14.
//  Copyright (c) 2014 CarlosGz. All rights reserved.
//

#import "CGZDropAndRotateBehavior.h"

static CGFloat const kAngleInDegrees = 100.0; // degrees for the dismissal presentation angle
static CGFloat const kAngularVelocity = -2.9; // The angular velocity, expressed in radians per second, that you want to add to the dynamic item
static float const kMagnitude = 4.0; // The magnitude of the gravity vector for the gravity behavior

@interface CGZDropAndRotateBehavior ()
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UIDynamicItemBehavior *animationOptions;
@end

@implementation CGZDropAndRotateBehavior

#pragma mark - Lifecycle

- (instancetype)initWithItem:(id<UIDynamicItem>)item
{
    self = [super init];
    if (self) {
        [self.gravityBehavior addItem:item];
        [self.animationOptions addItem:item];
        [self.animationOptions addAngularVelocity:kAngularVelocity forItem:item];
        
        [self addChildBehavior:self.gravityBehavior];
        [self addChildBehavior:self.animationOptions];
    }
    return self;
}

#pragma mark - Custom Accessors

-(UIGravityBehavior *)gravityBehavior
{
    if (!_gravityBehavior) {
        _gravityBehavior = [UIGravityBehavior new];
        _gravityBehavior.magnitude = kMagnitude;
        _gravityBehavior.angle = (kAngleInDegrees * M_PI) / 180;
    }
    return _gravityBehavior;
}

- (UIDynamicItemBehavior *)animationOptions
{
    if (!_animationOptions) {
        _animationOptions = [UIDynamicItemBehavior new];
    }
    return _animationOptions;
}

#pragma mark - Public

-(void)removeItem:(id <UIDynamicItem>)item
{
    [self.gravityBehavior removeItem:item];
    [self.animationOptions removeItem:item];
}

@end



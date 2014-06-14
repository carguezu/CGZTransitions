//
//  CGZDropAndRotateTransitionAnimator.h
//
//  Created by CarlosGz on 14/03/14.
//  Copyright (c) 2014 CarlosGz. All rights reserved.
//

@import Foundation;

@interface CGZDropAndRotateTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, getter = isPresenting) BOOL presenting;

/** Position correction into "y" axis of the presentingController */
@property (nonatomic) CGFloat yAxisPositionCorrection;

@end

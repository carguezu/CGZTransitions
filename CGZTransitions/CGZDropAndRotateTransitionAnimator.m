//
//  CGZDropAndRotateTransitionAnimator.m
//
//  Created by CarlosGz on 14/03/14.
//  Copyright (c) 2014 CarlosGz. All rights reserved.
//

#import "CGZDropAndRotateTransitionAnimator.h"
#import "CGZDropAndRotateBehavior.h"

static NSTimeInterval const kAnimatedTransitionDuration = 0.5f;

@interface CGZDropAndRotateTransitionAnimator ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@end

@implementation CGZDropAndRotateTransitionAnimator

#pragma mark - UIViewControllerAnimatedTransitioning Protocol

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresenting) {
        [self startEntryPresentation:transitionContext];
    } else {
        [self startDismissalPresentation:transitionContext];
    }
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return kAnimatedTransitionDuration;
}

#pragma mark - Custom Accessors

- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:[[UIApplication sharedApplication] windows][0]];
    }
    return _animator;
}

- (CGFloat)yAxisPositionCorrection
{
    if (!_yAxisPositionCorrection) {
        _yAxisPositionCorrection = 1.0;
    }
    return _yAxisPositionCorrection;
}

#pragma mark - Private

- (void) startEntryPresentation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    fromVC.view.userInteractionEnabled = NO;
    
    //[transitionContext.containerView addSubview:fromVC.view];
    [transitionContext.containerView addSubview:toVC.view];
    
    /// The toVC should start presenting at the center of the fromVC
    CGRect startFrame = [self startPresentingFrameFromViewController:fromVC
                                                 toTheViewController:toVC];
    
    /// The toVC should end presenting at the center of the FromVC frame with an optional custom "y" position
    CGRect endFrame = [self endPresentingFrameFromViewController:fromVC
                                             toTheViewController:toVC];
    
    toVC.view.frame = startFrame;
    
    [UIView animateWithDuration:1.0
                          delay:0.0
         usingSpringWithDamping:0.5
          initialSpringVelocity:0.8
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                            toVC.view.frame = endFrame;
                            
                        } completion:^(BOOL finished) {
                            
                            [transitionContext completeTransition:YES];
                            
                        }];
    
}

/** Calculate the initial position of the toVC in the fromVC
 *  The initial position will be at the top and the center of the fromVC
 * @param fromVC the current VC, the origin of the presentation
 * @param toVC the destination VC of the presentation
 * @return CGrect with the location and dimentions of the destination VC
 */
-(CGRect)startPresentingFrameFromViewController:(UIViewController *)fromVC
                            toTheViewController:(UIViewController *)toVC
{
    CGRect aRect = [toVC.view.subviews[0] frame];
    aRect.origin.x = fromVC.view.center.x - ([toVC.view.subviews[0] frame].size.width / 2);
    aRect.origin.y = 0;
    
    return aRect;
}

/** Calculate the final position of the toVC in the fromVC
 *  the final position will be at the center of the fromVC's coordinate axis
 * @param fromVC the current VC, the origin of the presentation
 * @param toVC the destination VC of the presentation
 * @return CGRect with the location and dimentions of the center of the destination VC
 */
-(CGRect)endPresentingFrameFromViewController:(UIViewController *)fromVC
                          toTheViewController:(UIViewController *)toVC
{
    CGRect aRect = [toVC.view.subviews[0] frame];
    aRect.origin.x = fromVC.view.center.x - ([toVC.view.subviews[0] frame].size.width / 2);
    aRect.origin.y = fromVC.view.center.y - ([toVC.view.subviews[0] frame].size.height / 2) * self.yAxisPositionCorrection;
    
    return aRect;
}

- (void) startDismissalPresentation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    toVC.view.userInteractionEnabled = YES;
    
    CGZDropAndRotateBehavior *dropAndRotateBehavior = [[CGZDropAndRotateBehavior alloc]initWithItem:fromVC.view];
    [self.animator addBehavior:dropAndRotateBehavior];
    
    double delayInSeconds = [self transitionDuration:transitionContext];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        
        [transitionContext completeTransition:YES];
        [dropAndRotateBehavior removeItem:fromVC.view];
        
    });

}

@end



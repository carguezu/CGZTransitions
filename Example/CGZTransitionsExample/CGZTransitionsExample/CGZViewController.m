//
//  CGZViewController.m
//  CGZTransitionsExample
//
//  Created by Carlos Gz on 02/06/14.
//  Copyright (c) 2014 CarlosGz. All rights reserved.
//

#import "CGZViewController.h"
#import "CGZMessageViewController.h"
#import "CGZDRopAndRotateTransitionAnimator.h"

@interface CGZViewController ()

@end

@implementation CGZViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)acceptButton:(UIButton *)sender
{
    CGZMessageViewController *destinationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CGZMessageViewController"];
    destinationVC.transitioningDelegate = self;
    destinationVC.message = @"Put your custom message here!";
    destinationVC.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:destinationVC animated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    UIViewController *detailViewController = segue.destinationViewController;
    detailViewController.transitioningDelegate = self;
    detailViewController.modalPresentationStyle = UIModalPresentationCustom;
}

#pragma mark - UIViewControllerTransitioningDelegate Methods

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    
    CGZDropAndRotateTransitionAnimator *animator = [CGZDropAndRotateTransitionAnimator new];
    animator.presenting = YES;
    // animator.yAxisPositionCorrection = 1.25; // Uncomment if you want to change the "y" position value
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    
    CGZDropAndRotateTransitionAnimator *animator = [CGZDropAndRotateTransitionAnimator new];
    animator.presenting = NO;
    return animator;
}


@end

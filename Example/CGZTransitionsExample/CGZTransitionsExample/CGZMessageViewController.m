//
//  CGZMessageViewController.m
//  CGZTransitionsExample
//
//  Created by Carlos Gz on 02/06/14.
//  Copyright (c) 2014 CarlosGz. All rights reserved.
//

#import "CGZMessageViewController.h"

@interface CGZMessageViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelMessage;
@end

@implementation CGZMessageViewController

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
    if (self.message) {
        self.labelMessage.text = self.message;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)closeButton:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}




@end

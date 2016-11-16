//
//  FourthViewController.m
//  ZDAssistiveTouchDemo
//
//  Created by ec on 2016/11/16.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import "FourthViewController.h"
#import "CallConferenceTransition.h"
#import "ZDAssistiveTouchView.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    
    UIButton *push = [UIButton buttonWithType:UIButtonTypeSystem];
    push.bounds = CGRectMake(0, 0, 60, 40);
    push.center = self.view.center;
    [push setTitle:@"Dismiss" forState:UIControlStateNormal];
    [push addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:push];
}

- (void)btnClicked {
    [self dismissViewControllerAnimated:YES completion:^{
        [ZDAssistiveTouchView show];
    }];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[CallConferenceTransition alloc] initWithTransitionType:CallConferenceTransitionTypePresent frame:[ZDAssistiveTouchView frame]];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[CallConferenceTransition alloc] initWithTransitionType:CallConferenceTransitionTypeDismiss frame:[ZDAssistiveTouchView frame]];
}

@end

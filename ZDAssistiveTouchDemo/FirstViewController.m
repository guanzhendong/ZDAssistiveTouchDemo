//
//  FirstViewController.m
//  ScreenEdgePanGestureDemo
//
//  Created by ec on 2016/11/9.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ZDAssistiveTouchView.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor brownColor];
    
    [ZDAssistiveTouchView show];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.bounds = CGRectMake(0, 0, 60, 40);
    btn.center = self.view.center;
    [btn setTitle:@"Push" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClicked {
    SecondViewController *vc = [SecondViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

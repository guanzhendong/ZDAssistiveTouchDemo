//
//  SecondViewController.m
//  ScreenEdgePanGestureDemo
//
//  Created by ec on 2016/11/9.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor purpleColor];
    
    
    
    // 自定义返回按钮后系统的右滑返回会失效
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 25);
    [btn setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = back;
    
    
    
    
    UIButton *push = [UIButton buttonWithType:UIButtonTypeSystem];
    push.bounds = CGRectMake(0, 0, 60, 40);
    push.center = self.view.center;
    [push setTitle:@"Push" forState:UIControlStateNormal];
    [push addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:push];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnClicked {
    ThirdViewController *vc = [ThirdViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end

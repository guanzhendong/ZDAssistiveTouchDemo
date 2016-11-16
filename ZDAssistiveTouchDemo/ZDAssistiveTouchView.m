//
//  ZDAssistiveTouchView.m
//  ZDAssistiveTouchDemo
//
//  Created by ec on 2016/11/16.
//  Copyright © 2016年 Code Geass. All rights reserved.
//

#import "ZDAssistiveTouchView.h"
#import "FourthViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

static CGFloat const kButtonSideLength = 60;///< 边长
static CGFloat const kMaxTopMarginToAdsorb = 100;///< 顶部、底部的最大吸附距离

@interface ZDAssistiveTouchView ()
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic, assign) CGPoint oldCenter;
@end

@implementation ZDAssistiveTouchView

+ (ZDAssistiveTouchView *)sharedView {
    static ZDAssistiveTouchView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)show {
    [[self sharedView] setup];
}

+ (void)remove {
    [[self sharedView].button removeFromSuperview];
    [self sharedView].button = nil;
}

+ (void)hide {
    [self sharedView].button.hidden = YES;
}

+ (CGRect)frame {
    return [self sharedView].button.frame;
}




#pragma mark -
#pragma mark - Set Up
- (void)setup {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(ScreenWidth - kButtonSideLength, 300, kButtonSideLength, kButtonSideLength);
        [_button setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:_button];
        [keyWindow bringSubviewToFront:_button];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)];
        [_button addGestureRecognizer:pan];
        
        [_button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    _button.hidden = NO;
}

#pragma mark - Clicked
- (void)buttonClicked {
    UINavigationController *rootVC = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = rootVC.topViewController;
    FourthViewController *fourthVC = [FourthViewController new];
    fourthVC.transitioningDelegate = fourthVC;
    [ZDAssistiveTouchView hide];
    [currentVC presentViewController:fourthVC animated:YES completion:nil];
}

#pragma mark - Pan
- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self];

    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            _beginPoint = location;
            _oldCenter = _button.center;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGFloat differenceX = location.x - _beginPoint.x;
            CGFloat differenceY = location.y - _beginPoint.y;
            _button.center = CGPointMake(_oldCenter.x + differenceX, _oldCenter.y + differenceY);
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            // 模拟系统的AssistiveTouch的效果
            CGPoint center = _button.center;
            if (center.y < kMaxTopMarginToAdsorb + kButtonSideLength/2) {
                if (center.x < center.y) {
                    // 吸附到左
                    [UIView animateWithDuration:0.3 animations:^{
                        _button.center = CGPointMake(kButtonSideLength/2, center.y);
                    }];
                }else if (center.x < ScreenWidth - center.y) {
                    // 吸附到上
                    [UIView animateWithDuration:0.3 animations:^{
                        _button.center = CGPointMake(center.x, kButtonSideLength/2);
                    }];
                }else {
                    // 吸附到右
                    [UIView animateWithDuration:0.3 animations:^{
                        _button.center = CGPointMake(ScreenWidth - kButtonSideLength/2, center.y);
                    }];
                }
            }else if (center.y < ScreenHeight - kMaxTopMarginToAdsorb - kButtonSideLength/2) {
                if (center.x < ScreenWidth/2) {
                    // 吸附到左
                    [UIView animateWithDuration:0.3 animations:^{
                        _button.center = CGPointMake(kButtonSideLength/2, center.y);
                    }];
                }else {
                    // 吸附到右
                    [UIView animateWithDuration:0.3 animations:^{
                        _button.center = CGPointMake(ScreenWidth - kButtonSideLength/2, center.y);
                    }];
                }
            }else {
                if (center.x < ScreenHeight - center.y) {
                    // 吸附到左
                    [UIView animateWithDuration:0.3 animations:^{
                        _button.center = CGPointMake(kButtonSideLength/2, center.y);
                    }];
                }else if (center.x < ScreenWidth - (ScreenHeight - center.y)) {
                    // 吸附到下
                    [UIView animateWithDuration:0.3 animations:^{
                        _button.center = CGPointMake(center.x, ScreenHeight - kButtonSideLength/2);
                    }];
                }else {
                    // 吸附到右
                    [UIView animateWithDuration:0.3 animations:^{
                        _button.center = CGPointMake(ScreenWidth - kButtonSideLength/2, center.y);
                    }];
                }
            }
        }
            break;
        default:
            break;
    }
}
@end

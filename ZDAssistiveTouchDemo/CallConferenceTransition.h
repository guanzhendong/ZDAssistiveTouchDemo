//
//  CallConferenceTransition.h
//  ECLite
//
//  Created by ec on 2016/11/1.
//  Copyright © 2016年 eclite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CallConferenceTransitionType) {
    CallConferenceTransitionTypePresent,
    CallConferenceTransitionTypeDismiss
};

@interface CallConferenceTransition : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTransitionType:(CallConferenceTransitionType)transitionType frame:(CGRect)frame;

@end

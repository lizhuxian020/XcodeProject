//
//  ZXTransitionDelegate.h
//  practice
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZXInteractiveTransitionActionDelegate <NSObject>

- (void)updateAniProgress:(CGFloat)progress;
- (void)finish;
- (void)cancel;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ZXTransitionDelegate : NSObject<UIViewControllerTransitioningDelegate>

@property(nonatomic, strong) id<ZXInteractiveTransitionActionDelegate> ITADelegate;

@end

NS_ASSUME_NONNULL_END

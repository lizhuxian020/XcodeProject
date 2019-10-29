//
//  ZXTransitionDelegate.m
//  practice
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ZXTransitionDelegate.h"

@interface _ZXACDelegate : NSObject<UIViewControllerAnimatedTransitioning>

@end

@implementation _ZXACDelegate

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 2;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
//    CGRect initialFrame = [transitionContext initialFrameForViewController:[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey]];
    CGRect finalRect = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalRect, UIScreen.mainScreen.bounds.size.width, 0);
    [[transitionContext containerView] addSubview:toVC.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext]  animations:^{
        toVC.view.frame = finalRect;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end

@interface _ZXITDelegate : NSObject<UIViewControllerInteractiveTransitioning, ZXInteractiveTransitionActionDelegate> {
    id <UIViewControllerContextTransitioning> _context;
}

@end

@implementation _ZXITDelegate

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"startIT");
    _context = transitionContext;
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    [transitionContext.containerView insertSubview:toVC.view belowSubview:fromVC.view];
    
//    [transitionContext completeTransition:YES];
}

- (void)updateAniProgress:(CGFloat)progress {
    NSLog(@"update");
    UIView *fromView = [_context viewForKey:UITransitionContextFromViewKey];
    CGRect finalRect = CGRectMake(UIScreen.mainScreen.bounds.size.width * progress, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    fromView.frame = finalRect;
}

- (void)finish {
    NSLog(@"finish");
    __weak id<UIViewControllerContextTransitioning> weakContext = _context;
    UIView *fromView = [_context viewForKey:UITransitionContextFromViewKey];
    [UIView animateWithDuration:.2 animations:^{
        fromView.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    } completion:^(BOOL finished) {
        [weakContext completeTransition:YES];
    }];
}

- (void)cancel {
    NSLog(@"cancel");
    __weak id<UIViewControllerContextTransitioning> weakContext = _context;
    UIView *fromView = [_context viewForKey:UITransitionContextFromViewKey];
    [UIView animateWithDuration:.2 animations:^{
        fromView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    } completion:^(BOOL finished) {
        [weakContext completeTransition:YES];
    }];
}

@end

@interface ZXTransitionDelegate () {
    id<UIViewControllerInteractiveTransitioning, ZXInteractiveTransitionActionDelegate> _ITADelegate;
    _ZXACDelegate *_acDelegate;
}

@end

@implementation ZXTransitionDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ITADelegate = [_ZXITDelegate new];
        _acDelegate = [_ZXACDelegate new];
    }
    return self;
}

/**
 用来设置将执行present时的动画

 @param presented 被present的VC
 @param presenting 将别的VCpresent出去的VC
 @param source 源VC, 跟presentingVC一样
 @return 返回动画配置
 */
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return _acDelegate;
}


/**
 设置dismiss时的配置

 @param dismissed 被dismiss的VC
 @return 返回动画配置
 */
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return _acDelegate;
}

/**
 设置present时, "可交互"的转场动画

 @param animator <#animator description#>
 @return <#return value description#>
 */
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
//    return _ITADelegate;
//}
//
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return _ITADelegate;
}
//
//- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0) {
//
//}

@end

//
//  PersentNormalViewController.m
//  practice
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "PersentNormalViewController.h"
#import "ZXTransitionDelegate.h"

@interface PersentNormalViewController () {
    UIPanGestureRecognizer *_pan;
    ZXTransitionDelegate *_transitionDelegate;
}

@end

@implementation PersentNormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.yellowColor;
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    _transitionDelegate = [ZXTransitionDelegate new];
    [self.view addGestureRecognizer:_pan];
}

- (void)pan:(UIPanGestureRecognizer *)g {
    CGPoint point = [g translationInView:self.view];
    CGFloat persent = point.x / UIScreen.mainScreen.bounds.size.width;
    NSLog(@"%f", persent);
    if (persent < 0) {
        return;
    }
    persent = fabs(persent);
    id<ZXInteractiveTransitionActionDelegate> delegate = _transitionDelegate.ITADelegate;
    switch (_pan.state) {
        case UIGestureRecognizerStateBegan: {
            NSLog(@"pan_begin");
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            NSLog(@"pan_progess");
            [delegate updateAniProgress:persent];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            NSLog(@"pan_end");
            if (persent > .5) {
                [delegate finish];
            } else {
                [delegate cancel];
            }
            break;
        }
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

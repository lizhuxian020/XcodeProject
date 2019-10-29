//
//  ViewController.m
//  practice
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ViewController.h"
#import "PersentNormalViewController.h"
#import "ZXTransitionDelegate.h"
@interface ViewController () {
    ZXTransitionDelegate *_transitionDelegate;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _transitionDelegate = [ZXTransitionDelegate new];
    
    self.view.backgroundColor = UIColor.brownColor;
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    PersentNormalViewController *vc = [PersentNormalViewController new];
    
    /**
     * 这是最简单的方法
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal; //水平翻转
    vc.modalTransitionStyle = UIModalTransitionStylePartialCurl; //由下至上"翻页"
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve; //渐隐渐现
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical; //默认: 由下至上Modal出现
    [self presentViewController:vc animated:1 completion:^{
        
    }];
     
     */
    
    vc.transitioningDelegate = _transitionDelegate;
    [self presentViewController:vc animated:YES completion:nil];
}


@end

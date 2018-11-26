//
//  BackPageViewController.h
//  ZhuiXiaoShuo
//
//  Created by 杨勇 on 2018/4/9.
//  Copyright © 2018年 Toprays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackPageViewController : UIViewController

@property (nonatomic,assign) UIViewController *currentViewController;
- (void)updateWithViewController:(UIViewController *)viewController;

@end

//
//  UIPageViewController+EnlargeTapRegion.m
//  BBReader
//
//  Created by GodLove on 2018/11/2.
//  Copyright © 2018 Toprays. All rights reserved.
//

#import "UIPageViewController+EnlargeTapRegion.h"

@implementation UIPageViewController (EnlargeTapRegion)

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        /// 控制tap的有效范围
//        UIView *touchView = touch.view;
//        CGPoint touchPoint = [touch locationInView:touchView];
//        CGFloat viewWidth = CGRectGetWidth(touchView.frame);
//        NSLog(@"viewWidth == %f,touchpoint == %@",viewWidth,[NSValue valueWithCGPoint:touchPoint]);
//        if (touchPoint.x < viewWidth/3 || touchPoint.x > viewWidth/3*2) {
//            return YES;
//        }else {
//            return NO;
//        }
        return NO;
    }
    return YES;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return NO;
//}

@end

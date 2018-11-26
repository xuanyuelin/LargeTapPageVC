//
//  ViewController.m
//  PageVCTest
//
//  Created by 小二黑挖土 on 2018/2/6.
//  Copyright © 2018年 小二黑挖土. All rights reserved.
//

#import "ViewController.h"
#import "ContentVC.h"
#import "BackPageViewController.h"

@interface ViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIGestureRecognizerDelegate>

@property(strong,nonatomic) UIPageViewController *pageVC;
@property(strong,nonatomic) ContentVC *contentVC;
@property(assign,nonatomic) NSInteger page;
@property (weak,nonatomic) UITapGestureRecognizer *weakTap;

@end

@implementation ViewController
{
    BOOL gestureMoved;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.pageVC setViewControllers:@[self.contentVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self addChildViewController:_pageVC];
//    [_pageVC didMoveToParentViewController:self];
    [self.view addSubview:_pageVC.view];
//    [self.view sendSubviewToBack:_pageVC.view];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelf:)];
    tap.delegate = self;
    _weakTap = tap;
    [self.view addGestureRecognizer:tap];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(ContentVC *)previousVC
{
    return [[ContentVC alloc] initWithPage:_page];
}
-(ContentVC *)nextVC
{
    return [[ContentVC alloc] initWithPage:_page];
}

- (BackPageViewController *)backVCAt:(UIViewController *)currentVC {
    BackPageViewController *backPage = [BackPageViewController new];
    [backPage updateWithViewController:currentVC];
    return backPage;
}

- (void)tapSelf:(UIGestureRecognizer *)gesture {
    NSLog(@"receive tap action !!!");
    UIView *touchView = gesture.view;
    CGPoint touchPoint = [gesture locationInView:touchView];
    CGFloat viewWidth = CGRectGetWidth(touchView.frame);
    if (touchPoint.x < viewWidth/3) {
        _page -= 2;
        UIViewController *preVC = [self previousVC];
        BackPageViewController *backVC = [self backVCAt:[self previousVC]];
        [self.pageVC setViewControllers:@[preVC,backVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }else if (touchPoint.x > viewWidth/3*2) {
        _page += 2;
        UIViewController *nextVC = [self nextVC];
        BackPageViewController *backVC = [self backVCAt:[self nextVC]];
        [self.pageVC setViewControllers:@[nextVC,backVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    UIView *touchView = gestureRecognizer.view;
    CGPoint touchPoint = [gestureRecognizer locationInView:touchView];
    CGFloat viewWidth = CGRectGetWidth(touchView.frame);
    if (gestureRecognizer == _weakTap) {
        if (touchPoint.x < viewWidth/3 || touchPoint.x > viewWidth/3*2) {
            return YES;
        }
    }
    return NO;
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    UIView *touchView = gestureRecognizer.view;
//    CGPoint touchPoint = [gestureRecognizer locationInView:touchView];
//    CGFloat viewWidth = CGRectGetWidth(touchView.frame);
//    if (touchPoint.x < viewWidth/3 || touchPoint.x > viewWidth/3*2) {
//        return YES;
//    }else {
//        return NO;
//    }
//}

#pragma mark - pageViewCtr delegaet && datasource
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    _page -= 1;
    if (_page % 2 == 1) {
        return [self backVCAt:[self previousVC]];
    }else {
        return [self previousVC];
    }
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    _page += 1;
    if (_page % 2 == 1) {
        return [self backVCAt:[self nextVC]];
    }else {
        return [self nextVC];
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    NSLog(@"pageController will transition");
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    NSLog(@"pageController finishAnimating,completed == %d",completed);
    _weakTap.enabled = YES;
}

-(UIPageViewController *)pageVC
{
    if(_pageVC == nil){
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageVC.delegate = self;
        _pageVC.dataSource = self;
        _pageVC.doubleSided = YES;
    }
    return _pageVC;
}
-(ContentVC *)contentVC
{
    if(_contentVC == nil){
        _contentVC = [[ContentVC alloc] initWithPage:0];
    }
    return _contentVC;
}

@end

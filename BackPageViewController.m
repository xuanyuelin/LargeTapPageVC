//
//  BackPageViewController.m
//  ZhuiXiaoShuo
//
//  Created by 杨勇 on 2018/4/9.
//  Copyright © 2018年 Toprays. All rights reserved.
//

#import "BackPageViewController.h"

@interface BackPageViewController ()

@property (nonatomic,strong)UIImage *backgroundImage;

@end

@implementation BackPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [imageView setImage:_backgroundImage];
    [imageView setAlpha:0.9];
    [self.view addSubview:imageView];
}

- (void)updateWithViewController:(UIViewController *)viewController
{
    self.backgroundImage = [self captureWithView:viewController.view];
    self.currentViewController = viewController;
}

-(UIImage *)captureWithView:(UIView *)view
{
    CGRect rect = view.bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGAffineTransform transform = CGAffineTransformMake(-1.0, 0.0, 0.0, 1.0, rect.size.width, 0.0);
    CGContextConcatCTM(context, transform);
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

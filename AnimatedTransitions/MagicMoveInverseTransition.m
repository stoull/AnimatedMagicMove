//
//  MagicMoveInverseTransition.m
//  AnimatedTransitions
//
//  Created by stoull on 12/24/15.
//  Copyright © 2015 AChang. All rights reserved.
//

#import "MagicMoveInverseTransition.h"
#import "MainCollectionViewController.h"
#import "DetailViewController.h"
#import "CollectionViewCell.h"
//#import "UIView+MotionBlur.h"

@implementation MagicMoveInverseTransition
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    // 获取动画前后两个VC 和 发生的容器containerView
    DetailViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    MainCollectionViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    // 在fromVC上创建一个截图
    UIView *snapShotView = [fromVC.detailImageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.backgroundColor = [UIColor clearColor];
    snapShotView.frame = [containerView convertRect:fromVC.detailImageView.frame fromView:fromVC.view];
    fromVC.detailImageView.hidden = YES;
    
    // 初始化toVC的位置
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    // 获取toVC中图片的位置
    CGRect cellRect = toVC.finalCellRect;
    CollectionViewCell *cell = (CollectionViewCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.indexPath];
    cell.imageView.hidden = YES;
    
    // 安排各图层的位置
    [containerView insertSubview:toVC.view aboveSubview:fromVC.view];
    [containerView addSubview:snapShotView];
    
    // 发生动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.6f initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromVC.view.alpha =0.0f;
        snapShotView.frame = cellRect;
    } completion:^(BOOL finished) {
        [snapShotView removeFromSuperview];
        cell.imageView.hidden = NO;
        //告诉系统动画结束
        [transitionContext completeTransition:YES];
    }];
}

@end

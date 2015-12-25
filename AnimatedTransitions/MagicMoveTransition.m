//
//  MagicMoveTransition.m
//  AnimatedTransitions
//
//  Created by stoull on 12/24/15.
//  Copyright © 2015 AChang. All rights reserved.
//

#import "MagicMoveTransition.h"
#import "MainCollectionViewController.h"
#import "DetailViewController.h"
#import "CollectionViewCell.h"
#import "UIView+MotionBlur.h"

@implementation MagicMoveTransition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.6f;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    // 获取两个vc 和动画发生的容器
    MainCollectionViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    DetailViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    // 对cell上的imageView进行截图，同时将这个imageView本身隐藏
    NSIndexPath *indexPath = [[fromVC.collectionView indexPathsForSelectedItems] firstObject];
    CollectionViewCell *cell = (CollectionViewCell *)[fromVC.collectionView cellForItemAtIndexPath:indexPath];
    fromVC.indexPath = indexPath;
    
    UIView *snapShotView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = fromVC.finalCellRect = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    cell.imageView.hidden = YES;
    
    // 设置第二个控制器的位置、透明度
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.detailImageView.hidden = YES;
    
    // 把动画前后的两个ViewController加到容器中，顺序很重要，snapShotView在上方
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    // 动画开始，第二个控制器的透明度0~1；让截图SnapShotView的位置更新到最新；
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        [containerView layoutIfNeeded];
        toVC.view.alpha = 1.0;
        snapShotView.frame = [containerView convertRect:toVC.detailImageView.frame fromView:toVC.view];
    } completion:^(BOOL finished) {
        //为了让回来的时候，cell上的图片显示，必须要让cell上的图片显示出来
        toVC.detailImageView.hidden = NO;
        cell.imageView.hidden = NO;
        [snapShotView removeFromSuperview];
        //告诉系统动画结束
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end

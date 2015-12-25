//
//  MainCollectionViewController.h
//  AnimatedTransitions
//
//  Created by stoull on 12/24/15.
//  Copyright © 2015 AChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewController : UICollectionViewController

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,assign)CGRect finalCellRect;

@end

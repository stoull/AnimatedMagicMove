//
//  CollectionViewCell.h
//  AnimatedTransitions
//
//  Created by stoull on 12/24/15.
//  Copyright © 2015 AChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *detailTextView;

@end

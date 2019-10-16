//
//  MyCell.h
//  MyCollectionView
//
//  Created by leeco on 2019/10/15.
//  Copyright © 2019 letv. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
NS_ASSUME_NONNULL_BEGIN
@class MyCell;
@protocol MyCellDelegate <NSObject>

-(void)myCell:(MyCell*)secondLevelCell scrollView:(UIScrollView*)scrollView;

@end
@interface MyCell : UICollectionViewCell
@property(nonatomic,weak)id<MyCellDelegate> delegate;
@property(strong,nonatomic)UICollectionView*itemCollectionView;

-(void)setNextLevelScrollViewEnable:(BOOL)canScroll;
@end

NS_ASSUME_NONNULL_END

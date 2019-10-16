//
//  MyCell.h
//  MyCollectionView
//
//  Created by leeco on 2019/10/15.
//  Copyright © 2019 letv. All rights reserved.
//
#ifdef __OBJC__
#import <UIKit/UIKit.h>

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@class MyFirstLevelCell;
@protocol MyCellDelegate <NSObject>

-(void)myCell:(MyFirstLevelCell*)secondLevelCell scrollView:(UIScrollView*)scrollView;

@end
@interface MyFirstLevelCell : UICollectionViewCell
@property(nonatomic,weak)id<MyCellDelegate> delegate;
@property(strong,nonatomic)UICollectionView*itemCollectionView;

-(void)setNextLevelScrollViewEnable:(BOOL)canScroll;
@end
 #endif

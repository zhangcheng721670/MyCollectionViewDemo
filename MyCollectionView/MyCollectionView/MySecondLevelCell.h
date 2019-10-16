//
//  MySecondLevelCell.h
//  MyCollectionView
//
//  Created by leeco on 2019/10/15.
//  Copyright © 2019 letv. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@class MySecondLevelCell;
@protocol MySecondLevelCellDelegate <NSObject>

-(void)secondLevelCell:(MySecondLevelCell*)secondLevelCell scrollView:(UIScrollView*)scrollView;

@end
@interface MySecondLevelCell : UICollectionViewCell
@property(nonatomic,weak)id<MySecondLevelCellDelegate> delegate;
@property(strong,nonatomic)UICollectionView*itemCollectionView;

@end

NS_ASSUME_NONNULL_END

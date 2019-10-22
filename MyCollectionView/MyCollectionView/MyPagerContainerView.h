//
//  MyPagerContainerView.h
//  MyCollectionView
//
//  Created by leeco on 2019/10/21.
//  Copyright © 2019 letv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPageCollectionView.h"

//@class MyPageCollectionView;
@class MyBgTableView;
@class MyPagerContainerView;
@protocol MyPagerContainerViewDelegate <NSObject>

- (NSInteger)numberOfRowsInListContainerView:(MyPagerContainerView *)listContainerView;

- (UIView *)listContainerView:(MyPagerContainerView *)listContainerView listViewInRow:(NSInteger)row;

- (void)listContainerView:(MyPagerContainerView *)listContainerView willDisplayCellAtRow:(NSInteger)row;

- (void)listContainerView:(MyPagerContainerView *)listContainerView didEndDisplayingCellAtRow:(NSInteger)row;

@end
@interface MyPagerContainerView : UIView

@property (nonatomic, strong, readonly) MyPageCollectionView *collectionView;
@property (nonatomic, weak) id<MyPagerContainerViewDelegate> delegate;
@property (nonatomic, weak) MyBgTableView *mainTableView;

- (instancetype)initWithDelegate:(id<MyPagerContainerViewDelegate>)delegate NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (void)reloadData;

@end


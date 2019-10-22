//
//  MyBgView.h
//  MyCollectionView
//
//  Created by leeco on 2019/10/21.
//  Copyright © 2019 letv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
@class MyBgView;
@class MyBgTableView;
@class MyPagerContainerView;


@interface MyBgView : UIView

@property (nonatomic, weak) id<MyPagerViewDelegate> delegate;

@property (nonatomic, strong, readonly) MyBgTableView *mainTableView;

@property (nonatomic, strong, readonly) MyPagerContainerView *listContainerView;

- (instancetype)initWithDelegate:(id<MyPagerViewDelegate>)delegate NS_DESIGNATED_INITIALIZER;

@property (nonatomic, assign) BOOL isListHorizontalScrollEnabled;     //是否允许列表左右滑动。默认：YES

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (void)initializeViews NS_REQUIRES_SUPER;

- (void)reloadData;

//可选调用：如果你的子列表在整个页面消失的时候(比如push到新的页面)，做一些暂停操作。比如列表有视频正在播放，离开的时候要暂停，就必须要调用该方法。使用示例在`PagingViewController`类。
- (void)currentListDidDisappear;
//可选调用：如果你的子列表在整个页面重新出现的时候(比如pop回来)，做一些恢复操作。比如继续播放之前的视频。就必须要调用该方法。使用示例在`PagingViewController`类。
- (void)currentListDidAppear;

#pragma mark - Subclass

@property (nonatomic, strong, readonly) UIScrollView *currentScrollingListView; //暴露给子类使用，请勿直接使用该属性！

@property (nonatomic, strong, readonly) id<MyPagerViewListViewDelegate> currentList;    //暴露给子类使用，请勿直接使用该属性！

@property (nonatomic, strong, readonly) NSDictionary <NSNumber *, id<MyPagerViewListViewDelegate>> *validListDict;   //当前已经加载过可用的列表字典，key就是index值，value是对应的列表。

- (void)preferredProcessListViewDidScroll:(UIScrollView *)scrollView;

- (void)preferredProcessMainTableViewDidScroll:(UIScrollView *)scrollView;

@end


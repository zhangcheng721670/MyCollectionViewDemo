//
//  MyBgView.m
//  MyCollectionView
//
//  Created by leeco on 2019/10/21.
//  Copyright © 2019 letv. All rights reserved.
//

#import "MyBgView.h"
#import "MyBgTableView.h"
#import "MyPagerContainerView.h"
#import "MyPageTableViewCell.h"
@interface MyBgView ()<UITableViewDataSource, UITableViewDelegate,MyPagerContainerViewDelegate>
@property (nonatomic, strong) MyBgTableView *mainTableView;
@property (nonatomic, strong) MyPagerContainerView *listContainerView;
@property (nonatomic, strong) UIScrollView *currentScrollingListView;
@property (nonatomic, strong) id<MyPagerViewListViewDelegate> currentList;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, id<MyPagerViewListViewDelegate>> *validListDict;
@property (nonatomic, assign) UIDeviceOrientation currentDeviceOrientation;
@property (nonatomic, assign) NSInteger currentIndex;
@end
@implementation MyBgView
- (instancetype)initWithDelegate:(id<MyPagerViewDelegate>)delegate {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _delegate = delegate;
        _validListDict = [NSMutableDictionary dictionary];
        [self initializeViews];
    }
    return self;
}
- (void)initializeViews {
    [self addSubview:self.mainTableView];
    self.isListHorizontalScrollEnabled = YES;

}
- (MyBgTableView *)mainTableView{
    if (!_mainTableView) {
        MyBgTableView*tableView = [[MyBgTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollsToTop = NO;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableHeaderView = [self.delegate tableHeaderViewInPagerView:self];
//        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _mainTableView = tableView;
    }
    return _mainTableView;
}
- (MyPagerContainerView *)listContainerView{
    if (!_listContainerView) {
        MyPagerContainerView * myListContainerView = [[MyPagerContainerView alloc] initWithDelegate:self];
        myListContainerView.mainTableView = self.mainTableView;
        _listContainerView = myListContainerView;
    }
    return _listContainerView;
}
- (void)layoutSubviews {
    [super layoutSubviews];

    self.mainTableView.frame = self.bounds;
}
- (void)setIsListHorizontalScrollEnabled:(BOOL)isListHorizontalScrollEnabled {
    _isListHorizontalScrollEnabled = isListHorizontalScrollEnabled;
    self.listContainerView.collectionView.scrollEnabled = isListHorizontalScrollEnabled;
}
#pragma mark - public method
- (void)reloadData {
    self.currentList = nil;
    self.currentScrollingListView = nil;

    for (id<MyPagerViewListViewDelegate> list in self.validListDict.allValues) {
        [list.listView removeFromSuperview];
    }
    [_validListDict removeAllObjects];

    self.mainTableView.tableHeaderView = [self.delegate tableHeaderViewInPagerView:self];
    [self.mainTableView reloadData];
    [self.listContainerView reloadData];
}
- (void)currentListDidAppear {
    [self listDidAppear:self.currentIndex];
}

- (void)currentListDidDisappear {
    [self listDidDisappear:self.currentIndex];
}

- (void)preferredProcessListViewDidScroll:(UIScrollView *)scrollView {
    if (self.mainTableView.contentOffset.y < [self.delegate tableHeaderViewHeightInPagerView:self]) {
        //mainTableView的header还没有消失，让listScrollView一直为0
        if (self.currentList && [self.currentList respondsToSelector:@selector(listScrollViewWillResetContentOffset)]) {
            [self.currentList listScrollViewWillResetContentOffset];
        }
        scrollView.contentOffset = CGPointZero;
        scrollView.showsVerticalScrollIndicator = NO;
    }else {
        //mainTableView的header刚好消失，固定mainTableView的位置，显示listScrollView的滚动条
        self.mainTableView.contentOffset = CGPointMake(0, [self.delegate tableHeaderViewHeightInPagerView:self]);
        scrollView.showsVerticalScrollIndicator = YES;
    }
}

- (void)preferredProcessMainTableViewDidScroll:(UIScrollView *)scrollView {
    if (self.currentScrollingListView != nil && self.currentScrollingListView.contentOffset.y > 0) {
        //mainTableView的header已经滚动不见，开始滚动某一个listView，那么固定mainTableView的contentOffset，让其不动
        self.mainTableView.contentOffset = CGPointMake(0, [self.delegate tableHeaderViewHeightInPagerView:self]);
    }

    if (scrollView.contentOffset.y < [self.delegate tableHeaderViewHeightInPagerView:self]) {
        //mainTableView已经显示了header，listView的contentOffset需要重置
        for (id<MyPagerViewListViewDelegate> list in self.validListDict.allValues) {
            if ([list respondsToSelector:@selector(listScrollViewWillResetContentOffset)]) {
                [list listScrollViewWillResetContentOffset];
            }
            [list listScrollView].contentOffset = CGPointZero;
        }
    }

    if (scrollView.contentOffset.y > [self.delegate tableHeaderViewHeightInPagerView:self] && self.currentScrollingListView.contentOffset.y == 0) {
        //当往上滚动mainTableView的headerView时，滚动到底时，修复listView往上小幅度滚动
        self.mainTableView.contentOffset = CGPointMake(0, [self.delegate tableHeaderViewHeightInPagerView:self]);
    }
}
#pragma mark - Private

- (void)listViewDidScroll:(UIScrollView *)scrollView {
    self.currentScrollingListView = scrollView;

    [self preferredProcessListViewDidScroll:scrollView];
}

- (void)listDidAppear:(NSInteger)index {
    NSUInteger count = [self.delegate numberOfListsInPagerView:self];
    if (count <= 0 || index >= count) {
        return;
    }
    self.currentIndex = index;

    id<MyPagerViewListViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listDidAppear)]) {
        [list listDidAppear];
    }
}

- (void)listDidDisappear:(NSInteger)index {
    NSUInteger count = [self.delegate numberOfListsInPagerView:self];
    if (count <= 0 || index >= count) {
        return;
    }
    id<MyPagerViewListViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listDidDisappear)]) {
        [list listDidDisappear];
    }
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = self.bounds.size.height - [self.delegate heightForPinSectionHeaderInPagerView:self];
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellind = @"cellind";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellind];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellind];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    cell.backgroundColor = [UIColor purpleColor];
    self.listContainerView.frame = CGRectMake(0, 0, self.mainTableView.frame.size.width, self.bounds.size.height - [self.delegate heightForPinSectionHeaderInPagerView:self]);//cell.bounds;
    [cell addSubview:self.listContainerView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.delegate heightForPinSectionHeaderInPagerView:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.delegate viewForPinSectionHeaderInPagerView:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(mainTableViewDidScroll:)]) {
        [self.delegate mainTableViewDidScroll:scrollView];
    }

    if (scrollView.isTracking && self.isListHorizontalScrollEnabled) {
        self.listContainerView.collectionView.scrollEnabled = NO;
    }

    [self preferredProcessMainTableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.isListHorizontalScrollEnabled) {
        self.listContainerView.collectionView.scrollEnabled = YES;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.isListHorizontalScrollEnabled) {
        self.listContainerView.collectionView.scrollEnabled = YES;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.isListHorizontalScrollEnabled) {
        self.listContainerView.collectionView.scrollEnabled = YES;
    }
}
#pragma mark - MyPagerContainerViewDelegate

- (NSInteger)numberOfRowsInListContainerView:(MyPagerContainerView *)listContainerView {
    return [self.delegate numberOfListsInPagerView:self];
}

- (UIView *)listContainerView:(MyPagerContainerView *)listContainerView listViewInRow:(NSInteger)row {
    id<MyPagerViewListViewDelegate> list = self.validListDict[@(row)];
    if (list == nil) {
        list = [self.delegate pagerView:self initListAtIndex:row];
        __weak typeof(self)weakSelf = self;
        __weak typeof(id<MyPagerViewListViewDelegate>) weakList = list;
        [list listViewDidScrollCallback:^(UIScrollView *scrollView) {
            weakSelf.currentList = weakList;
            [weakSelf listViewDidScroll:scrollView];
        }];
        _validListDict[@(row)] = list;
    }
    for (id<MyPagerViewListViewDelegate> listItem in self.validListDict.allValues) {
        if (listItem == list) {
            [listItem listScrollView].scrollsToTop = YES;
        }else {
            [listItem listScrollView].scrollsToTop = NO;
        }
    }

    return [list listView];
}

- (void)listContainerView:(MyPagerContainerView *)listContainerView willDisplayCellAtRow:(NSInteger)row {
    [self listDidAppear:row];
    self.currentScrollingListView = [self.validListDict[@(row)] listScrollView];
}

- (void)listContainerView:(MyPagerContainerView *)listContainerView didEndDisplayingCellAtRow:(NSInteger)row {
    [self listDidDisappear:row];
}

@end

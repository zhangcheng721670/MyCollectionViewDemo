//
//  MyBgView.m
//  MyCollectionView
//
//  Created by leeco on 2019/10/21.
//  Copyright © 2019 letv. All rights reserved.
//

#import "MyBgView.h"
#import "MyBgTableView.h"

@interface MyBgView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) MyBgTableView *mainTableView;

@end
@implementation MyBgView
- (MyBgTableView *)mainTableView{
    if (!_mainTableView) {
        MyBgTableView*tableView = [[MyBgTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollsToTop = NO;
        tableView.dataSource = self;
        tableView.delegate = self;
//        tableView.tableHeaderView = [self.delegate tableHeaderViewInPagerView:self];
        if (@available(iOS 11.0, *)) {
            self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _mainTableView = tableView;
    }
    return _mainTableView;
}

@end

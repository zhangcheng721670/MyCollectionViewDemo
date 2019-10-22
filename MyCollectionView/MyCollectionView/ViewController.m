//
//  ViewController.m
//  MyCollectionView
//
//  Created by leeco on 2019/10/15.
//  Copyright © 2019 letv. All rights reserved.
//

#import "ViewController.h"
#import "MyBgView.h"
#import "MyPageView.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define khEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController()<MyPagerViewDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyBgView*pagingView = [[MyBgView alloc] initWithDelegate:self];
    pagingView.frame = self.view.bounds;
    [self.view addSubview:pagingView];
}
#pragma mark - JXPagingViewDelegate

- (UIView *)tableHeaderViewInPagerView:(UIView *)pagerView {
    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 200)];
    view.backgroundColor = [UIColor redColor];
    return view;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(UIView *)pagerView {
    return 200;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(UIView *)pagerView {
    return 50;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(UIView *)pagerView {
    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 200)];
    view.backgroundColor = [UIColor greenColor];
    return view;
}

- (NSInteger)numberOfListsInPagerView:(UIView *)pagerView {
    return 3;
}

- (id<MyPagerViewListViewDelegate>)pagerView:(UIView *)pagerView initListAtIndex:(NSInteger)index {
    MyPageView *list = [[MyPageView alloc] init];
    if (index == 0) {
        list.dataSource = @[@"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮", @"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮"].mutableCopy;
    }else if (index == 1) {
        list.dataSource = @[@"吃烤肉", @"吃鸡腿肉", @"吃牛肉", @"各种肉"].mutableCopy;
    }else if (index == 2) {
        list.dataSource = @[@"【剑士】罗罗诺亚·索隆", @"【航海士】娜美", @"【狙击手】乌索普", @"【厨师】香吉士", @"【船医】托尼托尼·乔巴", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾"].mutableCopy;
    }
    return list;
}

- (void)mainTableViewDidScroll:(UIScrollView *)scrollView {
//    [self.userHeaderView scrollViewDidScroll:scrollView.contentOffset.y];
}


@end

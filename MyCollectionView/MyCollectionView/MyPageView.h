//
//  MyPageView.h
//  MyCollectionView
//
//  Created by leeco on 2019/10/21.
//  Copyright © 2019 letv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyPageView : UIView<MyPagerViewListViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSString *> *dataSource;

@end

NS_ASSUME_NONNULL_END

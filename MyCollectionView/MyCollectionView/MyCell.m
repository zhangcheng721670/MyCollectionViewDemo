//
//  MyCell.m
//  MyCollectionView
//
//  Created by leeco on 2019/10/15.
//  Copyright © 2019 letv. All rights reserved.
//

#import "MyCell.h"
#import "MySecondLevelCell.h"
@interface MyCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MySecondLevelCellDelegate>
@end
@implementation MyCell
-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.itemCollectionView];
    }
    return self;
}
- (UICollectionView *)itemCollectionView {
    if (!_itemCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _itemCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWidth,  kHeight-50-20) collectionViewLayout:layout];
        _itemCollectionView.delegate = self;
        _itemCollectionView.dataSource = self;
        [_itemCollectionView registerClass:[MySecondLevelCell class] forCellWithReuseIdentifier:@"item"];
        _itemCollectionView.backgroundColor = [UIColor clearColor];
        _itemCollectionView.showsHorizontalScrollIndicator = YES;
        _itemCollectionView.pagingEnabled = YES;
        _itemCollectionView.bounces = NO;
    }
    return _itemCollectionView;
}
#pragma mark - collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kWidth,  kHeight-50-20);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        MySecondLevelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item"
                                                                               forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
    cell.delegate = self;
        return cell;
   
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)setNextLevelScrollViewEnable:(BOOL)canScroll{
    
}

- (void)secondLevelCell:(MySecondLevelCell *)secondLevelCell scrollView:(UIScrollView *)scrollView{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(myCell:scrollView:)]) {
           [self.delegate myCell:self scrollView:scrollView];
       }
}
@end

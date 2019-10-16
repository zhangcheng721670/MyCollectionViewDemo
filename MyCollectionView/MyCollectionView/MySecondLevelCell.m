//
//  MySecondLevelCell.m
//  MyCollectionView
//
//  Created by leeco on 2019/10/15.
//  Copyright © 2019 letv. All rights reserved.
//

#import "MySecondLevelCell.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@interface MySecondLevelCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@end
@implementation MySecondLevelCell
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
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _itemCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWidth,  kHeight-50-20) collectionViewLayout:layout];
        _itemCollectionView.delegate = self;
        _itemCollectionView.dataSource = self;
        [_itemCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
        _itemCollectionView.backgroundColor = [UIColor clearColor];
        _itemCollectionView.showsHorizontalScrollIndicator = NO;
        _itemCollectionView.showsVerticalScrollIndicator = NO;
        _itemCollectionView.scrollEnabled = NO;
        _itemCollectionView.bounces = YES;
    }
    return _itemCollectionView;
}
#pragma mark - collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((kWidth-30)/2.f,  (kWidth-30)/2.f);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item"
                                                                               forIndexPath:indexPath];
        cell.backgroundColor = [UIColor darkGrayColor];
    cell.largeContentTitle = [NSString stringWithFormat:@"%d---%d",indexPath.section,indexPath.item];
        return cell;
   
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(secondLevelCell:scrollView:)]) {
        [self.delegate secondLevelCell:self scrollView:self.itemCollectionView];
    }
}
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
//        return nil;
//    }
//    if ([self pointInside:point withEvent:event]) {
//        for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
//            CGPoint convertedPoint = [subview convertPoint:point fromView:self];
//            UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
//            if (hitTestView) {
//                return hitTestView;
//            }
//        }
//        return self;
//    }
//    return nil;
//}
@end

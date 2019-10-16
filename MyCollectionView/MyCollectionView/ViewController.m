//
//  ViewController.m
//  MyCollectionView
//
//  Created by leeco on 2019/10/15.
//  Copyright © 2019 letv. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
#import "MySecondLevelCell.h"

#import "MyHeader.h"
#import "MyLayout.h"


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MyCellDelegate>
@property(strong,nonatomic)UICollectionView*toolCollectionView;
@end

@implementation ViewController
- (UICollectionView *)toolCollectionView {
    if (!_toolCollectionView) {
        
        MyLayout *layout = [[MyLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _toolCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, kWidth,  kHeight-20) collectionViewLayout:layout];
        _toolCollectionView.delegate = self;
        _toolCollectionView.dataSource = self;
        [_toolCollectionView registerClass:[MyCell class] forCellWithReuseIdentifier:@"cell1"];
        [_toolCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell2"];
        [_toolCollectionView registerClass:[MyHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
        _toolCollectionView.backgroundColor = [UIColor clearColor];
        _toolCollectionView.showsHorizontalScrollIndicator = YES;
        _toolCollectionView.bounces = NO;
    }
    return _toolCollectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.toolCollectionView];
    
}
#pragma mark - collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }
    return 1;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(kWidth, 100);
    }
    return CGSizeMake(kWidth, kHeight-50-20);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2"
                                                                               forIndexPath:indexPath];
        cell.backgroundColor = [UIColor redColor];
        return cell;
    }else {
        MyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1"
                                                                               forIndexPath:indexPath];
        cell.backgroundColor = [UIColor orangeColor];
        cell.delegate =self;
        return cell;
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section != 0) {
            return CGSizeMake(kWidth, 50);

    }
    return  CGSizeZero;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    MyHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor purpleColor];
    return headerView;
}
- (void)myCell:(MyCell *)secondLevelCell scrollView:(UIScrollView *)scrollView{
    NSLog(@"self.toolCollectionView.contentOffset.y====%f",self.toolCollectionView.contentOffset.y);
    if (scrollView.contentOffset.y == 0) {
        scrollView.scrollEnabled = NO;
    } else {
//        scrollView.scrollEnabled = YES;
    }
//    scrollView.scrollEnabled = !self.toolCollectionView.contentOffset.y<100;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y == 100) {
        MyCell*cell = [self.toolCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
        UICollectionView*collectionView1 = cell.itemCollectionView;
        NSInteger index = collectionView1.contentOffset.x/kWidth;
        MySecondLevelCell*cell2 = [collectionView1 cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        UICollectionView*collectionView2 = cell2.itemCollectionView;
        collectionView2.scrollEnabled = YES;
//        self.toolCollectionView.scrollEnabled = NO;
//        scrollView = collectionView2;
    }
}
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    if (self.toolCollectionView.contentOffset.y == 100) {
//        if ([self pointInside:point withEvent:event]) {
//            for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
//                CGPoint convertedPoint = [subview convertPoint:point fromView:self];
//                UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
//                if (hitTestView) {
//                    return hitTestView;
//                }
//            }
//            return self;
//        }
//        MyCell*cell = [self.toolCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
//        UICollectionView*collectionView1 = cell.itemCollectionView;
//        NSInteger index = collectionView1.contentOffset.x/kWidth;
//        MySecondLevelCell*cell2 = [collectionView1 cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
//        UICollectionView*collectionView2 = cell2.itemCollectionView;
//        return collectionView2;
//    }else {
//        return self.toolCollectionView;
//    }
//    return nil;
//}
@end

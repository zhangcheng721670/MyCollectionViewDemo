//
//  MyPageTableViewCell.m
//  MyCollectionView
//
//  Created by leeco on 2019/10/22.
//  Copyright © 2019 letv. All rights reserved.
//

#import "MyPageTableViewCell.h"
@interface MyPageTableViewCell()
@property(nonatomic,strong)UILabel * titleLabel;
@end
@implementation MyPageTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"%@",NSStringFromCGRect(self.bounds));
    self.titleLabel.frame = self.bounds;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel*lab = [[UILabel alloc]init];
        lab.backgroundColor = [UIColor yellowColor];
        _titleLabel = lab;
    }
    return _titleLabel;
}
@end

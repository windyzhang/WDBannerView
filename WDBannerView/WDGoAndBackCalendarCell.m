//
//  WDGoAndBackCalendarCell.m
//  WDBannerView
//
//  Created by Mac on 2018/7/4.
//  Copyright © 2018年 windy. All rights reserved.
//

#import "WDGoAndBackCalendarCell.h"

@interface WDGoAndBackCalendarCell()

@property (strong, nonatomic) UILabel *topLeft;
@property (strong, nonatomic) UILabel *topRight;
@property (weak, nonatomic) CALayer *backgroundLayer;

@end

@implementation WDGoAndBackCalendarCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews {
    
    CALayer *backLayer = [[CALayer alloc] init];
    backLayer.backgroundColor = [UIColor orangeColor].CGColor;
    backLayer.actions = @{@"hidden":[NSNull null]};
    [self.contentView.layer insertSublayer:backLayer below:self.titleLabel.layer];
    self.backgroundLayer = backLayer;
    
    self.shapeLayer.hidden = YES;
    
    UILabel *left = [[UILabel alloc] init];
    left.textColor = [UIColor whiteColor];
    left.font = [UIFont systemFontOfSize:7];
    [self addSubview:left];
    self.topLeft = left;
    
    UILabel *right = [[UILabel alloc] init];
    right.textColor = [UIColor blackColor];
    right.font = [UIFont systemFontOfSize:8.0];
    [self addSubview:right];
    self.topRight = right;
    
}

- (void)setCellSelected:(BOOL)cellSelected {
    
    if (self.selectedable) {
        if (cellSelected) {
            _backgroundLayer.backgroundColor = [UIColor orangeColor].CGColor;
        } else {
            _backgroundLayer.backgroundColor = [UIColor whiteColor].CGColor;
        }
        _topLeft.textColor = [UIColor whiteColor];
        _topRight.textColor = [UIColor orangeColor];
        self.subtitleLabel.textColor = self.preferredSubtitleDefaultColor;
    }
}

- (void)setMiddleOfSelected:(BOOL)middleOfSelected {
    
    if (self.selectedable) {
        if (middleOfSelected) {
            _backgroundLayer.backgroundColor = [UIColor orangeColor].CGColor;
        }
    }
}

@end

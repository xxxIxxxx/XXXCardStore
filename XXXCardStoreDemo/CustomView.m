//
//  CustomView.m
//  XXXCardStoreDemo
//
//  Created by 赵云飞 on 2018/7/6.
//  Copyright © 2018年 赵云飞. All rights reserved.
//

#import "CustomView.h"
@interface CustomView ()

@property (nonatomic, strong) UIView *leftV;
@property (nonatomic, strong) UIView *rightV;
@property (nonatomic, strong) UILabel *lab;

@end


@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}


- (void)initViews {
    UILabel *lab = [UILabel new];
    [self addSubview:lab];
    lab.frame = CGRectMake(0, 20, 50, 50);
    self.lab = lab;
    
    UIView *lv = [UIView new];
    [self addSubview:lv];
    lv.backgroundColor = [UIColor orangeColor];
    lv.frame = CGRectMake(0, 80, 60, 60);
    self.leftV = lv;
    
    UIView *rv = [UIView new];
    [self addSubview:rv];
    rv.backgroundColor = [UIColor redColor];
    rv.frame = CGRectMake(100, 80, 60, 60);
    self.rightV = rv;
    
}

- (void)setIndex:(NSInteger)index {
    
    _index = index;
    self.backgroundColor = [UIColor darkGrayColor];
    self.lab.text = [NSString stringWithFormat:@"%ld",index];
    self.leftV.hidden = NO;
    self.rightV.hidden = NO;
    if (index%2 == 0) {
        self.rightV.hidden = YES;
    }
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  CustomView.m
//  XXXCardStoreDemo
//
//  Created by 赵云飞 on 2018/7/6.
//  Copyright © 2018年 赵云飞. All rights reserved.
//

#import "CustomView.h"

#import "XXXCardStore/XXXCardStore.h"

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
    
    /// 创建一个和cardView一样大小的 放视图，然后对cardView layer做处理
    UIView *boView = [UIView new];
    [self addSubview:boView];
    boView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    boView.backgroundColor = [UIColor whiteColor];
    boView.layer.cornerRadius = 7.0;
    boView.layer.masksToBounds = YES;
    
    UILabel *lab = [UILabel new];
    [boView addSubview:lab];
    lab.frame = CGRectMake(0, 20, 50, 50);
    self.lab = lab;
    
    UIView *lv = [UIView new];
    [boView addSubview:lv];
    lv.backgroundColor = [UIColor orangeColor];
    lv.frame = CGRectMake(0, 80, 60, 60);
    self.leftV = lv;
    
    UIView *rv = [UIView new];
    [boView addSubview:rv];
    rv.backgroundColor = [UIColor redColor];
    rv.frame = CGRectMake(100, 80, 60, 60);
    self.rightV = rv;
    
    
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowOffset = CGSizeMake(1, 2);
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    
}

- (void)setIndex:(NSInteger)index {
    
    _index = index;
    self.lab.text = [NSString stringWithFormat:@"%ld",(long)index];
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

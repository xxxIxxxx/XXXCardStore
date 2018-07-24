//
//  XXXCardStore.m
//  XXXCardStoreDemo
//
//  Created by 赵云飞 on 2018/7/4.
//  Copyright © 2018年 赵云飞. All rights reserved.
//

#import "XXXCardStore.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface XXXCardStore ()
#define IMGV_Tag 777

@property (nonatomic, strong) NSMutableArray<UIView *> *cardViewArr;
@property (nonatomic, unsafe_unretained) CGFloat cardHeight;
@property (nonatomic, unsafe_unretained) CGPoint cardInwindowCenter;

@property (nonatomic, unsafe_unretained) NSInteger bottomShowCardIndex;

@property (nonatomic, strong) UIView *nowMoveCardView;

@end

@interface UIView (XXXCardStore)

@property (nonatomic) CGFloat height_xxx;
@property (nonatomic) CGFloat width_xxx;
@property (nonatomic) CGFloat centerX_xxx;
@property (nonatomic) CGFloat centerY_xxx;



@end

@implementation UIView (XXXCardStore)


- (void)setHeight_xxx:(CGFloat)height_xxx {
    CGRect frame = self.frame;
    frame.size.height = height_xxx;
    self.frame = frame;
}

- (CGFloat)height_xxx {
    return self.frame.size.height;
}

- (void)setWidth_xxx:(CGFloat)width_xxx {
    CGRect frame = self.frame;
    frame.size.width = width_xxx;
    self.frame = frame;
}

- (CGFloat)width_xxx {
    return self.frame.size.width;
}

- (CGFloat)centerX_xxx
{
    return CGRectGetMinX(self.frame) + self.width_xxx * 0.5;
}

- (void)setCenterX_xxx:(CGFloat)centerX_xxx {
    CGRect frame = self.frame;
    frame.origin.x = centerX_xxx - self.width_xxx * 0.5;
    self.frame = frame;
}

- (CGFloat)centerY_xxx
{
    return CGRectGetMinY(self.frame) + self.height_xxx * 0.5;
}

- (void)setCenterY_xxx:(CGFloat)centerY_xxx {
    CGRect frame = self.frame;
        frame.origin.y = centerY_xxx - self.height_xxx * 0.5;
        self.frame = frame;
}


@end


@implementation XXXCardStore


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.cardViewArr = [NSMutableArray array];
        _currentIndex = 0;
        self.showOverlayCount = 3;
        self.cardOffset = 5.0;
        self.cancleDistance = 70.0;
        self.isInfiniteLoop = YES;
        self.cardCount = -1;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGes:)];
        [self addGestureRecognizer:pan];
        
    }
    return self;
}

- (void)reloadData {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    self.cardHeight = self.height_xxx - (self.showOverlayCount-1)*self.cardOffset;
    
    if (self.cardViewArr.count > 0) {
        [self.cardViewArr enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.transform = CGAffineTransformIdentity;
            [self addGesture:obj];
            obj.width_xxx = self.width_xxx;
            obj.height_xxx = self.cardHeight;
            obj.center = CGPointMake(self.width_xxx/2.0, self.cardHeight/2.0+idx*self.cardOffset);
            float offset = self.cardOffset/self.cardHeight;
            [self animationView:obj scale:1.0 - offset*idx duration:0.1];
        }];
        
        return;
    }
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    NSInteger count = self.showOverlayCount;
    for (NSInteger i = 0; i < count; i++) {
        UIView *cardView = [UIView new];
        CGRect rect = CGRectMake(0, i*self.cardOffset, self.width_xxx, self.cardHeight);
        cardView.frame = rect;
        if (self.customCardView) {
            cardView = [[self.customCardView.class alloc] initWithFrame:rect];
        }
        [self insertSubview:cardView atIndex:0];
        
        [self addGesture:cardView];
        
        if ([_delegate respondsToSelector:@selector(customCardView:index:cardStore:)] && self.customCardView) {
            [_delegate customCardView:cardView index:i cardStore:self];
        }else{
            UIImageView *imageV = [UIImageView new];
            [cardView addSubview:imageV];
            imageV.frame = CGRectMake(0, 0, self.width_xxx, self.cardHeight);
            [imageV sd_setImageWithURL:[NSURL URLWithString:self.imgUrlStrArr[i]] placeholderImage:self.placeholderImage];
            imageV.contentMode = self.imgContentMode;
            imageV.tag = IMGV_Tag;
        }
        float offset = self.cardOffset/self.cardHeight;
        [self animationView:cardView scale:1.0-offset*i duration:0.1];
        [self.cardViewArr addObject:cardView];
        
    }
}

- (void)applicationDidBecomeActive {
    [self addSubview:self.nowMoveCardView];
    self.nowMoveCardView.center = CGPointMake(self.width_xxx/2.0, self.cardHeight/2.0);
    [self animationView:self.nowMoveCardView scale:1 duration:0.001];
}

- (void)panGes:(UIPanGestureRecognizer *)pan {
    
    UIView *cardView = self.cardViewArr.firstObject;
    self.nowMoveCardView = cardView;
    if (pan.state == UIGestureRecognizerStateBegan) {
        UIWindow *kWindow = [UIApplication sharedApplication].keyWindow;
        CGPoint oriPoint = [cardView convertRect:cardView.frame toView:kWindow].origin;
        [[UIApplication sharedApplication].keyWindow addSubview:cardView];
        cardView.centerX_xxx = oriPoint.x + cardView.width_xxx/2.0;
        cardView.centerY_xxx = oriPoint.y + cardView.height_xxx/2.0;
        self.cardInwindowCenter = CGPointMake(cardView.centerX_xxx, cardView.centerY_xxx);
        if (self.isScale) {
            [self animationView:cardView scale:0.9 duration:0.001];
        }
        
    }
    
    CGPoint transLcation = [pan translationInView:self];
    cardView.center = CGPointMake(self.cardInwindowCenter.x+transLcation.x, self.cardInwindowCenter.y+transLcation.y);

    float xP = transLcation.x / (self.width_xxx/2.0);
    if (xP < -1) xP = -1;
    if (xP > 1) xP = 1;
    CGFloat rotation = M_PI_2/4*xP;
    [self animationView:cardView rotate:rotation];
    
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        ///移动的对角线长
        float moveC = hypot(fabs(transLcation.x),fabs(transLcation.y));
        ///放回原处
        if (moveC < self.cancleDistance) {
            [self addSubview:cardView];
            cardView.center = CGPointMake(self.width_xxx/2.0, self.cardHeight/2.0);
            [self animationView:cardView scale:1 duration:0.001];
            self.nowMoveCardView = nil;
            return;
        }
        
        UIView *reuseView = cardView;
        cardView.hidden = YES;
        if (self.cardViewArr.count > 0) {
            [self.cardViewArr removeObjectAtIndex:0];
        }
        [cardView removeFromSuperview];
        
        self.showOverlayCount --;
        ///
        _currentIndex ++;
        if (_currentIndex == self.imgUrlStrArr.count && self.imgUrlStrArr) _currentIndex = 0;
        if (_currentIndex == self.cardCount) _currentIndex = 0;
        
        /// 即将加入cardStore底部card index
        self.bottomShowCardIndex = _currentIndex + self.showOverlayCount;
        if (self.bottomShowCardIndex >= self.imgUrlStrArr.count && self.imgUrlStrArr) self.bottomShowCardIndex = self.bottomShowCardIndex - self.imgUrlStrArr.count;
        
        if (self.bottomShowCardIndex >= self.cardCount && self.cardCount > - 1) self.bottomShowCardIndex = self.bottomShowCardIndex - self.cardCount;
        
        
        if (self.isInfiniteLoop) {
            reuseView.hidden = NO;
            self.showOverlayCount ++;
            if ([_delegate respondsToSelector:@selector(customCardView:index:cardStore:)] && self.customCardView) {
                [_delegate customCardView:cardView index:self.bottomShowCardIndex cardStore:self];
            }else{
                UIImageView *imgV = [cardView viewWithTag:IMGV_Tag];
                [imgV sd_setImageWithURL:[NSURL URLWithString:self.imgUrlStrArr[self.bottomShowCardIndex]] placeholderImage:self.placeholderImage];
            }
            reuseView.center = CGPointMake(self.width_xxx/2.0, self.cardHeight/2.0+(self.showOverlayCount+1)*self.cardOffset);
            float offset = self.cardOffset/self.cardHeight;
            [self animationView:reuseView scale:1-offset*(self.showOverlayCount+1) duration:0.00001];
            [self.cardViewArr addObject:reuseView];
            [self insertSubview:reuseView atIndex:0];
            self.nowMoveCardView = nil;
        }
        [self reloadData];
    }
}


- (void)addGesture:(UIView *)cardView {
    cardView.userInteractionEnabled = YES;
    [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
}

- (void)tapClick {
    if ([_delegate respondsToSelector:@selector(tapCard:cardStore:)]) {
        [_delegate tapCard:_currentIndex cardStore:self];
    }
}

- (void)animationView:(UIView *)cardView scale:(CGFloat)scale duration:(CFTimeInterval)duration {
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        cardView.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, 1);
    } completion:^(BOOL finished) {
    }];
}

- (void)animationView:(UIView *)cardView rotate:(CGFloat)angle {
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        float r = 1.0;
        if (self.isScale) {
            r = 0.9;
        }
        cardView.transform = CGAffineTransformRotate(CGAffineTransformScale(CGAffineTransformIdentity, r, 1), angle);
    } completion:^(BOOL finished) {
    }];
}


- (void)dealloc {
    NSLog(@"---  XXXCardStore  dealloc ----");
}

@end





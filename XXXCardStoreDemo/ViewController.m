//
//  ViewController.m
//  XXXCardStoreDemo
//
//  Created by 赵云飞 on 2018/7/7.
//  Copyright © 2018年 赵云飞. All rights reserved.
//

#import "ViewController.h"
#import "XXXCardStore.h"
#import "CustomView.h"

@interface ViewController ()<XXXCardStoreDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton new];
    [self.view addSubview:btn];
    float w = 300.0  ,left = ([UIScreen mainScreen].bounds.size.width - w) /2.0;
    btn.frame = CGRectMake(left, 500, w, 50);
    
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(sssss) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}


- (void)tapCard:(NSInteger)index cardStore:(UIView *)xxxCardStore{
    if (xxxCardStore.tag == 7) {
        NSLog(@"--- custom tap   ===  %ld",index);
        return;
    }
    NSLog(@"--- tap   ===  %ld",index);
}

- (void)customCardView:(UIView *)customCard index:(NSInteger)index cardStore:(UIView *)xxxCardStore {
    if (xxxCardStore.tag == 7) {
        CustomView *cv = (CustomView *)customCard;
        cv.index = index;
    }
}


- (void)sssss {
    
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[UIButton class]]) {
            [obj removeFromSuperview];
        }
        
    }];
    XXXCardStore *xxx = [XXXCardStore new];
    [self.view addSubview:xxx];
    float w = 300.0 ,h = 180.0 ,left = ([UIScreen mainScreen].bounds.size.width - w) /2.0;
    xxx.frame = CGRectMake(left, 100, w, h);
    xxx.cardOffset = 10.0;
    xxx.isInfiniteLoop =YES;
    xxx.delegate = self;
    xxx.imgUrlStrArr = @[@"http://f.hiphotos.baidu.com/image/pic/item/203fb80e7bec54e7c340af43b2389b504fc26a3b.jpg",
                         @"http://d.hiphotos.baidu.com/image/pic/item/0d338744ebf81a4c6231d43ddb2a6059242da6c6.jpg",
                         @"http://a.hiphotos.baidu.com/image/pic/item/4e4a20a4462309f788a28152790e0cf3d6cad6a4.jpg",
                         @"http://d.hiphotos.baidu.com/image/pic/item/810a19d8bc3eb135101902e6ad1ea8d3fc1f4494.jpg",
                         @"http://f.hiphotos.baidu.com/image/pic/item/86d6277f9e2f0708a5559f5de224b899a901f21f.jpg",
                         @"http://h.hiphotos.baidu.com/image/pic/item/ca1349540923dd5441e81235da09b3de9d8248d7.jpg",
                         @"http://c.hiphotos.baidu.com/image/pic/item/faedab64034f78f09d3f2eae72310a55b3191cb2.jpg",
                         @"http://d.hiphotos.baidu.com/image/pic/item/622762d0f703918f037f88975a3d269758eec4c5.jpg"
                         ];
    [xxx reloadData];
    
    
    
    
    
    XXXCardStore *customXxx = [XXXCardStore new];
    [self.view addSubview:customXxx];
    customXxx.frame = CGRectMake(left, 100+h+5, w, h);
    customXxx.cardOffset = 10.0;
    customXxx.isInfiniteLoop =YES;
    customXxx.delegate = self;
    customXxx.cardCount = 17;
    customXxx.customCardView = [CustomView new];
    customXxx.tag = 7;
    [customXxx reloadData];
    
    
    UIButton *btn1 = [UIButton new];
    [self.view addSubview:btn1];
    btn1.frame = CGRectMake(left-5, 0, 5, 500);
    btn1.backgroundColor = [UIColor purpleColor];
    
    UIButton *btn2 = [UIButton new];
    [self.view addSubview:btn2];
    btn2.frame = CGRectMake(left+w, 0, 5, 500);
    btn2.backgroundColor = [UIColor purpleColor];
    
    
    UIButton *btn3 = [UIButton new];
    [self.view addSubview:btn3];
    btn3.frame = CGRectMake(0, 95, 5000, 5);
    btn3.backgroundColor = [UIColor purpleColor];
    
    
    UIButton *btn4 = [UIButton new];
    [self.view addSubview:btn4];
    btn4.frame = CGRectMake(0, 100+h, 5000, 5);
    btn4.backgroundColor = [UIColor purpleColor];
    
    
    UIButton *btn5 = [UIButton new];
    [self.view addSubview:btn5];
    btn5.frame = CGRectMake(0, 100+h+5+h, 5000, 5);
    btn5.backgroundColor = [UIColor purpleColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

# [github XXXCardStore](https://github.com/xxxIxxxx/XXXCardStore)

![效果图](https://ws3.sinaimg.cn/large/006tKfTcgy1ft1i8fhehog309s0hee83.gif)

![说明图](https://ws2.sinaimg.cn/large/006tKfTcgy1ft1i8fvdbwj30b70h7q6b.jpg)

### 导入
1. pod search XXXCardStore
如未搜索到 请执行 pod repo update 进行更新，然后清除搜索缓存 rm ~/Library/Caches/CocoaPods/search_index.json
2. pod 'XXXCardStore'
3. import < XXXCardStore .h>



### 使用
```
- (void)viewDidLoad {
	[super viewDidLoad];
XXXCardStore *xxx = [XXXCardStore new];
	[self.view addSubview:xxx];
	xxx.frame = CGRectMake(50, 100, 300, 200);
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
}

- (void)tapCard:(NSInteger)index cardStore:(UIView *)xxxCardStore{

	NSLog(@"--- tap   ===  %ld",index);
}

```

### ⚠️注意⚠️ 防止界面切换时 卡片停留在window层

```
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.cardView resetCardView];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.cardView resetCardView];
}
```


### 自定义卡片内容
```
/**
 自定义卡片内容
 
 @param customCard 你的customView 内部试图未清除
 @param index 需要准备的 card的 index
 @param xxxCardStore xxxCardStore 主体
 */
- (void)customCardView:(UIView *)customCard index:(NSInteger)index cardStore:(UIView *)xxxCardStore;
```
